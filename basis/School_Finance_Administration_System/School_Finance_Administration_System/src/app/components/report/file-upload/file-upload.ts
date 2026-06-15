import { Component, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';

interface PreviewImage {
  file: File;
  url: string;
  name: string;
}

@Component({
  selector: 'app-file-upload',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './file-upload.html',
  styleUrls: ['./file-upload.css'],
})
export class FileUpload implements OnDestroy {
  images: PreviewImage[] = [];
  isDragOver = false;

  onFilesSelected(event: Event) {
    const input = event.target as HTMLInputElement;
    if (!input || !input.files) return;

    const files = Array.from(input.files);
    files.forEach((file) => {
      if (!file.type.startsWith('image/')) return;
      const url = URL.createObjectURL(file);
      this.images.push({ file, url, name: file.name });
    });

    // allow selecting the same file again
    input.value = '';
  }

  onDragOver(event: DragEvent) {
    event.preventDefault();
    this.isDragOver = true;
  }

  onDragLeave(event: DragEvent) {
    event.preventDefault();
    this.isDragOver = false;
  }

  onDrop(event: DragEvent) {
    event.preventDefault();
    this.isDragOver = false;
    if (!event.dataTransfer) return;
    const files = Array.from(event.dataTransfer.files || []);
    files.forEach((file) => {
      if (!file.type.startsWith('image/')) return;
      const url = URL.createObjectURL(file);
      this.images.push({ file, url, name: file.name });
    });
  }

  removeImage(index: number) {
    const img = this.images[index];
    if (img) {
      URL.revokeObjectURL(img.url);
      this.images.splice(index, 1);
    }
  }

  ngOnDestroy(): void {
    this.images.forEach((img) => URL.revokeObjectURL(img.url));
  }
}
