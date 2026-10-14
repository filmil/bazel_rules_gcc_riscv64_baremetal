package main

import (
	"bytes"
	"testing"
)

func TestConvert(t *testing.T) {
	in := bytes.NewReader([]byte{0x01, 0x02, 0x03})
	if err := Convert(in); err != nil {
		t.Fatalf("Convert failed: %v", err)
	}
}
