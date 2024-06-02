Return-Path: <linux-kernel+bounces-198485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D528D7927
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 01:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16081F2151D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 23:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B747D096;
	Sun,  2 Jun 2024 23:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b="ELxkzDJF"
Received: from smtp-out.freemail.hu (fmfe17.freemail.hu [46.107.16.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B343F78283
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 23:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.107.16.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717371219; cv=none; b=mitYhhr4VRffofuo61qzjc1ictaMTIPcyAXGPvPcP4l+DVASJmw2xsPWphqbdddnoxFPKOjg7aUhy4sEtog7hGhCO27mCqUT1QwFQJ8l3BqEZ3Xy/Z6E7SD7TpSyRpztiT9h9CRxCS7I/lgWTy34J9xluU6/c6lUppVewu9J+TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717371219; c=relaxed/simple;
	bh=jaA9RKU8QoyMaMB7ZEarIcCGhuA2fwlIoYxPYii1AFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rfiAMFXIMaNx+sS8hAsqjIYdUSOHuhP6ogvrCG4xyaomQIZ0h8nShzQZlRLlJOHh6Iy2z7lgWF90uZIeCB0f5Bf7ID7OrnTDU5acf3G8qo6fgM5ROnvG2PI2mntE8463jwKs2Ny5y/VjCAsw7Ve8CsBHqZshkMaLgIycH3IvlCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu; spf=pass smtp.mailfrom=freemail.hu; dkim=fail (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b=ELxkzDJF reason="signature verification failed"; arc=none smtp.client-ip=46.107.16.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freemail.hu
Received: from [192.168.0.16] (catv-80-98-74-198.catv.fixed.vodafone.hu [80.98.74.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4VstLn25b4z2vv;
	Mon,  3 Jun 2024 01:27:45 +0200 (CEST)
Message-ID: <d8366db0-ceeb-44c5-bef3-8cffb9d74860@freemail.hu>
Date: Mon, 3 Jun 2024 01:27:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau/i2c: rename aux.c and aux.h to nvkm_i2c_aux.c
 and nvkm_i2c_aux.h
To: Ben Skeggs <bskeggs@nvidia.com>, kherbst@redhat.com, lyude@redhat.com,
 airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240601212247.54786-1-egyszeregy@freemail.hu>
 <233ba844-7964-42ad-8962-95c371e402be@nvidia.com>
Content-Language: hu, en-US
From: =?UTF-8?Q?Sz=C5=91ke_Benjamin?= <egyszeregy@freemail.hu>
In-Reply-To: <233ba844-7964-42ad-8962-95c371e402be@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1717370867;
	s=20181004; d=freemail.hu;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	l=7588; bh=MEMKy+zpzeM/b0SV9PKLhstRFfWTgKmOq/rJvbhZwXQ=;
	b=ELxkzDJF/zs+wcGNMvH0gkpPqrA7mgMbamXNgxisVoafyqaOEcLygqrt+S5R4/AV
	mn48KjRdpXTWR3//Jz3VpSnQQc2WS45dQDoaQhv9sd5ce/NnZo8NYQP2WWdTVCs2Btb
	DsrUkDeG3dTngNRc/sdesH6EBp+qhnCDCnvyXzIWYvKMRXP3koNq56e6dSxRZ4C4bHF
	/x8widEcfvs8giZ4FPhpXoooJTpj2Hoc9p4vZgsM7xxWmNe2Uob2vp4thdjG8noCmYO
	3O8BtHqJYSpbTjJGu1JNdjew6rhNa81nLdQlIgM6mo5U24gCte+QdpN07InOMwMW1gE
	mFAXUDVTmQ==

2024. 06. 03. 0:08 keltezéssel, Ben Skeggs írta:
> On 2/6/24 07:22, egyszeregy@freemail.hu wrote:
> 
>> From: Benjamin Szőke <egyszeregy@freemail.hu>
>>
>> The goal is to clean-up Linux repository from AUX file names, because
>> the use of such file names is prohibited on other operating systems
>> such as Windows, so the Linux repository cannot be cloned and
>> edited on them.
>>
>> Signed-off-by: Benjamin Szőke <egyszeregy@freemail.hu>
>> ---
>>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild                  | 2 +-
>>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c               | 2 +-
>>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c                | 2 +-
>>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c              | 2 +-
>>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c              | 2 +-
>>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c                  | 2 +-
>>   .../gpu/drm/nouveau/nvkm/subdev/i2c/{aux.c => nvkm_i2c_aux.c}   | 2 +-
>>   .../gpu/drm/nouveau/nvkm/subdev/i2c/{aux.h => nvkm_i2c_aux.h}   | 0
>>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c                | 2 +-
>>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c              | 2 +-
>>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c              | 2 +-
>>   11 files changed, 10 insertions(+), 10 deletions(-)
>>   rename drivers/gpu/drm/nouveau/nvkm/subdev/i2c/{aux.c => nvkm_i2c_aux.c} (99%)
>>   rename drivers/gpu/drm/nouveau/nvkm/subdev/i2c/{aux.h => nvkm_i2c_aux.h} (100%)
> 
> NACK on this rename.  No other part of NVKM uses filenames like this. If 
> anything, auxch.[ch] would be a better choice.
> 
> Ben.

Do you mean it would be better to rename them in the following way?

rename drivers/gpu/drm/nouveau/nvkm/subdev/i2c/{aux.c => auxc.c}
rename drivers/gpu/drm/nouveau/nvkm/subdev/i2c/{aux.h => auxh.h}


> 
>>
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild 
>> b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild
>> index 819703913a00..c488dfce4392 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild
>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild
>> @@ -25,7 +25,7 @@ nvkm-y += nvkm/subdev/i2c/busnv50.o
>>   nvkm-y += nvkm/subdev/i2c/busgf119.o
>>   nvkm-y += nvkm/subdev/i2c/bit.o
>> -nvkm-y += nvkm/subdev/i2c/aux.o
>> +nvkm-y += nvkm/subdev/i2c/nvkm_i2c_aux.o
>>   nvkm-y += nvkm/subdev/i2c/auxg94.o
>>   nvkm-y += nvkm/subdev/i2c/auxgf119.o
>>   nvkm-y += nvkm/subdev/i2c/auxgm200.o
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c 
>> b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c
>> index dd391809fef7..30bf84e77db9 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c
>> @@ -24,7 +24,7 @@
>>   #define anx9805_pad(p) container_of((p), struct anx9805_pad, base)
>>   #define anx9805_bus(p) container_of((p), struct anx9805_bus, base)
>>   #define anx9805_aux(p) container_of((p), struct anx9805_aux, base)
>> -#include "aux.h"
>> +#include "nvkm_i2c_aux.h"
>>   #include "bus.h"
>>   struct anx9805_pad {
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c 
>> b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c
>> index 47068f6f9c55..9e07ba444ca8 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c
>> @@ -22,7 +22,7 @@
>>    * Authors: Ben Skeggs <bskeggs@redhat.com>
>>    */
>>   #define g94_i2c_aux(p) container_of((p), struct g94_i2c_aux, base)
>> -#include "aux.h"
>> +#include "nvkm_i2c_aux.h"
>>   struct g94_i2c_aux {
>>       struct nvkm_i2c_aux base;
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c 
>> b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c
>> index dab40cd8fe3a..8709b728c38b 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c
>> @@ -19,7 +19,7 @@
>>    * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>    * OTHER DEALINGS IN THE SOFTWARE.
>>    */
>> -#include "aux.h"
>> +#include "nvkm_i2c_aux.h"
>>   static const struct nvkm_i2c_aux_func
>>   gf119_i2c_aux = {
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c 
>> b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c
>> index 8bd1d442e465..f40c5709d217 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c
>> @@ -22,7 +22,7 @@
>>    * Authors: Ben Skeggs <bskeggs@redhat.com>
>>    */
>>   #define gm200_i2c_aux(p) container_of((p), struct gm200_i2c_aux, base)
>> -#include "aux.h"
>> +#include "nvkm_i2c_aux.h"
>>   struct gm200_i2c_aux {
>>       struct nvkm_i2c_aux base;
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c 
>> b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c
>> index 976539de4220..736275f0c774 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c
>> @@ -22,7 +22,7 @@
>>    * Authors: Ben Skeggs
>>    */
>>   #include "priv.h"
>> -#include "aux.h"
>> +#include "nvkm_i2c_aux.h"
>>   #include "bus.h"
>>   #include "pad.h"
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c 
>> b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/nvkm_i2c_aux.c
>> similarity index 99%
>> rename from drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c
>> rename to drivers/gpu/drm/nouveau/nvkm/subdev/i2c/nvkm_i2c_aux.c
>> index d063d0dc13c5..6b76df02c63a 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/nvkm_i2c_aux.c
>> @@ -24,7 +24,7 @@
>>   #include <linux/string_helpers.h>
>> -#include "aux.h"
>> +#include "nvkm_i2c_aux.h"
>>   #include "pad.h"
>>   static int
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.h 
>> b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/nvkm_i2c_aux.h
>> similarity index 100%
>> rename from drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.h
>> rename to drivers/gpu/drm/nouveau/nvkm/subdev/i2c/nvkm_i2c_aux.h
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c 
>> b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c
>> index 5904bc5f2d2a..e9c55a57c878 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c
>> @@ -22,7 +22,7 @@
>>    * Authors: Ben Skeggs
>>    */
>>   #include "pad.h"
>> -#include "aux.h"
>> +#include "nvkm_i2c_aux.h"
>>   #include "bus.h"
>>   void
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c 
>> b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c
>> index 3bc4d0310076..1af64e25d838 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c
>> @@ -22,7 +22,7 @@
>>    * Authors: Ben Skeggs
>>    */
>>   #include "pad.h"
>> -#include "aux.h"
>> +#include "nvkm_i2c_aux.h"
>>   #include "bus.h"
>>   static const struct nvkm_i2c_pad_func
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c 
>> b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c
>> index 7d417f6a816e..997a5a2146c4 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c
>> @@ -22,7 +22,7 @@
>>    * Authors: Ben Skeggs
>>    */
>>   #include "pad.h"
>> -#include "aux.h"
>> +#include "nvkm_i2c_aux.h"
>>   #include "bus.h"
>>   static void


