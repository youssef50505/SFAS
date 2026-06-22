import { Component, Input, Self, Optional, ElementRef, ViewChild } from '@angular/core';
import { ControlValueAccessor, NgControl, ReactiveFormsModule, FormControl } from '@angular/forms';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-file-upload',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './file-upload.component.html',
  styleUrl: './file-upload.component.css'
})
export class FileUploadComponent implements ControlValueAccessor {
  @Input() label = '';
  @Input() id = '';
  @Input() accept = 'image/*,.pdf';
  
  @ViewChild('fileInput') fileInput!: ElementRef<HTMLInputElement>;
  fileName = '';

  constructor(@Self() @Optional() public controlDir: NgControl) {
    if (this.controlDir) {
      this.controlDir.valueAccessor = this;
    }
  }

  get control() {
    return this.controlDir?.control as FormControl;
  }

  onFileSelected(event: Event) {
    const file = (event.target as HTMLInputElement).files?.[0];
    if (file) {
      this.fileName = file.name;
      this.control.setValue(file.name);
      this.control.markAsDirty();
    }
  }

  writeValue(obj: any): void {
    if (typeof obj === 'string') {
      this.fileName = obj;
    } else {
      this.fileName = '';
    }
  }
  registerOnChange(fn: any): void {}
  registerOnTouched(fn: any): void {}
}
