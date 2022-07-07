<?php

namespace App\Http\Controllers\Api;

use App\Upload;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Storage;

class UploadsController extends Controller
{
    public function destroy($id)
    {
        $ass = Upload::find($id);
        Storage::delete($ass->images);
        $file = Upload::find($id)->delete();
        return response()->json(['file' => $file], 200);
    }
}
