Return-Path: <linux-kernel+bounces-198036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 930298D72A8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 01:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FD75281F28
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 23:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E8D3B2BB;
	Sat,  1 Jun 2024 23:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b="1oSo+wfG"
Received: from smtp-out.freemail.hu (fmfe15.freemail.hu [46.107.16.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6B22032D
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 23:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.107.16.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717283269; cv=none; b=MeYnYHxPynislvjvkni0H02uQKRb9qb/V11BFCv54W1dO//pZVyQ5l7knMnXvXZF0UnjJmTuHFdHZHiR0yrPRekeDrMYFcSn3OBDZRRy5TNekv12b7RCMifU7qapNjjknZ8t88xOukVmyPJdKFn5dgfkj+b+Lbn6C2aPJdAd7LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717283269; c=relaxed/simple;
	bh=CjxhuTad7d4nqApWl4u2bxSLcayNi88xTRB9tCUnO+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mcy6GI/wDqssaoobB0NktG4rDOgOs9KMPSQRwumqLmrzPRTyHxZFDIsdYgts+i5XMuAv4BnEdyL5XO+UaFLfd5/POnDxH3osIzi375YV7HYxGt3G7erGnydnQzAHz9xO2vhFXy9jg1QoM3I3shKSDEDqjVbCr8O8Ta0Ru17PzJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu; spf=pass smtp.mailfrom=freemail.hu; dkim=fail (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b=1oSo+wfG reason="signature verification failed"; arc=none smtp.client-ip=46.107.16.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freemail.hu
Received: from [192.168.0.16] (catv-80-98-74-198.catv.fixed.vodafone.hu [80.98.74.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4VsFpH2ncXzMZ;
	Sun,  2 Jun 2024 01:00:55 +0200 (CEST)
Message-ID: <bec5f516-211d-4c6e-9204-311d1e31532a@freemail.hu>
Date: Sun, 2 Jun 2024 01:00:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau/i2c: rename aux.c and aux.h to nvkm_i2c_aux.c
 and nvkm_i2c_aux.h
To: Karol Herbst <kherbst@redhat.com>
Cc: bskeggs@redhat.com, lyude@redhat.com, airlied@gmail.com, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240601212247.54786-1-egyszeregy@freemail.hu>
 <CACO55tvW7zDRt=ka0w5D8drbJiZFqMFmx=n=PttAjubZJ5zX2Q@mail.gmail.com>
Content-Language: hu, en-US
From: =?UTF-8?Q?Sz=C5=91ke_Benjamin?= <egyszeregy@freemail.hu>
In-Reply-To: <CACO55tvW7zDRt=ka0w5D8drbJiZFqMFmx=n=PttAjubZJ5zX2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1717282857;
	s=20181004; d=freemail.hu;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	l=8472; bh=iw0a2TUtlt0KIetu+spJR9WLW1F3MPSfBbxxiBBkhDM=;
	b=1oSo+wfGjIoAfhgzfBaxNDoTN0TmXW/jadL52HL5ZAyzWMk15XqSBLjBkAd//Bh9
	u1d+ypo+idz4sTys/CYP5oS8lb8fepRTYBFboPsOAnbHQg6tR0QizBnjyYGq1iMYD02
	GmZWamFVQ/I9kT0XMOMhoKNp1jmr3tFr0iaoS+PqyGv5aNFi6tmiFSJT5fnNaf8/Bct
	XgidaouR1QSqrB6vgHDUjd13+165V+RoCh/CflqZroE132r01M9mxZU5bk4M4uMO38l
	HwZjS8YTSOmTA49PcLYbh+hr+e+GVFHP+X1wgmd/93wqlySRgqM7N1fh84jucg03IMS
	D/tvbePTzg==

2024. 06. 02. 0:12 keltezéssel, Karol Herbst írta:
> On Sat, Jun 1, 2024 at 11:33 PM <egyszeregy@freemail.hu> wrote:
>>
>>          s=20181004; d=freemail.hu;
>>          h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
>>          l=6462; bh=CnHSqkRX34kqCWN2/oPtvm9wm8HJCe8QhPwQypdpi3w=;
>>          b=JDlDB9yOQDBY7EDnRMrt8qYnWfH8J/LKYKb90434FH1tuOL04za+3TXXSbU0uvs0
>>          hWYDYjpbob4XGgUcd1s+lCkerOgDwkpWJWKFW8N5j6WENAKdR/hWJgcma2JEDDotXZ0
>>          cisYRrLsQBfjyKkBWw0qv/5PDe7vliytix5oP2piBPJC+uR3pN8OKck/+zLBGlJY4za
>>          qywwOiMNzHAdyOJT5kCg0yd+k186Oa1jX93iCpiRk5mxJQqJJcAxfW8rYbKRXi5QQTl
>>          SymDGdZ72wK5PkHxGgpZ9qXZtFV3eH4+95xNzpoPowMkXFkBy1uMClZzxv1oBmRo8o6
>>          CXPcfsWUsQ==
>> Content-Transfer-Encoding: quoted-printable
>>
>> From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
>>
>> The goal is to clean-up Linux repository from AUX file names, because
>> the use of such file names is prohibited on other operating systems
>> such as Windows, so the Linux repository cannot be cloned and
>> edited on them.
>>
> 
> something went horribly wrong with encoding so the patch is pretty much invalid.
> 
>> Signed-off-by: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
>> ---
>>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild                  | 2 +-
>>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c               | 2 +-
>>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c                | 2 +-
>>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c              | 2 +-
>>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c              | 2 +-
>>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c                  | 2 +-
>>   .../gpu/drm/nouveau/nvkm/subdev/i2c/{aux.c =3D> nvkm_i2c_aux.c}   | 2 +-
>>   .../gpu/drm/nouveau/nvkm/subdev/i2c/{aux.h =3D> nvkm_i2c_aux.h}   | 0
>>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c                | 2 +-
>>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c              | 2 +-
>>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c              | 2 +-
>>   11 files changed, 10 insertions(+), 10 deletions(-)
>>   rename drivers/gpu/drm/nouveau/nvkm/subdev/i2c/{aux.c =3D> nvkm_i2c_aux.=
>> c} (99%)
>>   rename drivers/gpu/drm/nouveau/nvkm/subdev/i2c/{aux.h =3D> nvkm_i2c_aux.=
>> h} (100%)
>>
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild b/drivers/gpu=
>> /drm/nouveau/nvkm/subdev/i2c/Kbuild
>> index 819703913a00..c488dfce4392 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild
>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild
>> @@ -25,7 +25,7 @@ nvkm-y +=3D nvkm/subdev/i2c/busnv50.o
>>   nvkm-y +=3D nvkm/subdev/i2c/busgf119.o
>>   nvkm-y +=3D nvkm/subdev/i2c/bit.o
>> =20
>> -nvkm-y +=3D nvkm/subdev/i2c/aux.o
>> +nvkm-y +=3D nvkm/subdev/i2c/nvkm_i2c_aux.o
>>   nvkm-y +=3D nvkm/subdev/i2c/auxg94.o
>>   nvkm-y +=3D nvkm/subdev/i2c/auxgf119.o
>>   nvkm-y +=3D nvkm/subdev/i2c/auxgm200.o
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c b/drivers/=
>> gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c
>> index dd391809fef7..30bf84e77db9 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c
>> @@ -24,7 +24,7 @@
>>   #define anx9805_pad(p) container_of((p), struct anx9805_pad, base)
>>   #define anx9805_bus(p) container_of((p), struct anx9805_bus, base)
>>   #define anx9805_aux(p) container_of((p), struct anx9805_aux, base)
>> -#include "aux.h"
>> +#include "nvkm_i2c_aux.h"
>>   #include "bus.h"
>> =20
>>   struct anx9805_pad {
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c b/drivers/g=
>> pu/drm/nouveau/nvkm/subdev/i2c/auxg94.c
>> index 47068f6f9c55..9e07ba444ca8 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c
>> @@ -22,7 +22,7 @@
>>    * Authors: Ben Skeggs <bskeggs@redhat.com>
>>    */
>>   #define g94_i2c_aux(p) container_of((p), struct g94_i2c_aux, base)
>> -#include "aux.h"
>> +#include "nvkm_i2c_aux.h"
>> =20
>>   struct g94_i2c_aux {
>>          struct nvkm_i2c_aux base;
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c b/drivers=
>> /gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c
>> index dab40cd8fe3a..8709b728c38b 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c
>> @@ -19,7 +19,7 @@
>>    * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>    * OTHER DEALINGS IN THE SOFTWARE.
>>    */
>> -#include "aux.h"
>> +#include "nvkm_i2c_aux.h"
>> =20
>>   static const struct nvkm_i2c_aux_func
>>   gf119_i2c_aux =3D {
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c b/drivers=
>> /gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c
>> index 8bd1d442e465..f40c5709d217 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c
>> @@ -22,7 +22,7 @@
>>    * Authors: Ben Skeggs <bskeggs@redhat.com>
>>    */
>>   #define gm200_i2c_aux(p) container_of((p), struct gm200_i2c_aux, base)
>> -#include "aux.h"
>> +#include "nvkm_i2c_aux.h"
>> =20
>>   struct gm200_i2c_aux {
>>          struct nvkm_i2c_aux base;
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c b/drivers/gpu=
>> /drm/nouveau/nvkm/subdev/i2c/base.c
>> index 976539de4220..736275f0c774 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c
>> @@ -22,7 +22,7 @@
>>    * Authors: Ben Skeggs
>>    */
>>   #include "priv.h"
>> -#include "aux.h"
>> +#include "nvkm_i2c_aux.h"
>>   #include "bus.h"
>>   #include "pad.h"
>> =20
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c b/drivers/gpu/=
>> drm/nouveau/nvkm/subdev/i2c/nvkm_i2c_aux.c
>> similarity index 99%
>> rename from drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c
>> rename to drivers/gpu/drm/nouveau/nvkm/subdev/i2c/nvkm_i2c_aux.c
>> index d063d0dc13c5..6b76df02c63a 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/nvkm_i2c_aux.c
>> @@ -24,7 +24,7 @@
>> =20
>>   #include <linux/string_helpers.h>
>> =20
>> -#include "aux.h"
>> +#include "nvkm_i2c_aux.h"
>>   #include "pad.h"
>> =20
>>   static int
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.h b/drivers/gpu/=
>> drm/nouveau/nvkm/subdev/i2c/nvkm_i2c_aux.h
>> similarity index 100%
>> rename from drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.h
>> rename to drivers/gpu/drm/nouveau/nvkm/subdev/i2c/nvkm_i2c_aux.h
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c b/drivers/g=
>> pu/drm/nouveau/nvkm/subdev/i2c/padg94.c
>> index 5904bc5f2d2a..e9c55a57c878 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c
>> @@ -22,7 +22,7 @@
>>    * Authors: Ben Skeggs
>>    */
>>   #include "pad.h"
>> -#include "aux.h"
>> +#include "nvkm_i2c_aux.h"
>>   #include "bus.h"
>> =20
>>   void
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c b/drivers=
>> /gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c
>> index 3bc4d0310076..1af64e25d838 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c
>> @@ -22,7 +22,7 @@
>>    * Authors: Ben Skeggs
>>    */
>>   #include "pad.h"
>> -#include "aux.h"
>> +#include "nvkm_i2c_aux.h"
>>   #include "bus.h"
>> =20
>>   static const struct nvkm_i2c_pad_func
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c b/drivers=
>> /gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c
>> index 7d417f6a816e..997a5a2146c4 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c
>> @@ -22,7 +22,7 @@
>>    * Authors: Ben Skeggs
>>    */
>>   #include "pad.h"
>> -#include "aux.h"
>> +#include "nvkm_i2c_aux.h"
>>   #include "bus.h"
>> =20
>>   static void
>> --=20
>> 2.43.0
>>
> 

Hi,

This patched is totally fine and visible in "linux-kernel@vger.kernel.org" list 
page, so it should not be invalid. Please check your e-mail client SW and fix 
your settings.

https://lore.kernel.org/lkml/20240601212247.54786-1-egyszeregy@freemail.hu/
https://lore.kernel.org/lkml/20240601212247.54786-1-egyszeregy@freemail.hu/raw

kernel test robot used it for a build test successfully, so it has to be a valid 
patch.
https://github.com/intel-lab-lkp/linux/commits/egyszeregy-freemail-hu/drm-nouveau-i2c-rename-aux-c-and-aux-h-to-nvkm_i2c_aux-c-and-nvkm_i2c_aux-h/20240602-053530


