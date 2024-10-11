Return-Path: <linux-kernel+bounces-360924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 318D999A167
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDDF32831F2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A51C1E3773;
	Fri, 11 Oct 2024 10:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b="jvt7JZkL"
Received: from smtp-out.freemail.hu (fmfe36.freemail.hu [46.107.16.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3521991AF
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.107.16.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728642731; cv=none; b=mRYBdJ9+EKa399UC/1B/4VawOn1s0GNBEI3GtrBUwjO9edc+xiAa7TJ/JfSM9a8ERFUgNG2dodfBnOrfDajowNeI9i2NlJEqgFDG2P7O+wJB0gJVuRDb4Gs0jrePJ8HOz9gsM3/ycARzSmU+oP2qMUQsZbHPnCPi/MqClZLx4PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728642731; c=relaxed/simple;
	bh=wBma+ItmBOwZcRQzQpUqQkWXcDIKan3tg7AsNCuZdbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FhdOjgUw71g84hB8tZiQfe0a3AL604tNxdYhNac0tU9lcb85vTOtkGl7/haKlXZbAMJpF2Qm4ioJOXvo2hz4c1SrFCoPeEwRiLPEBVWyLFp28iCUdysc/3ZL8Tni3Pwj491Xay2m+LXZBW+ECbG9mZSXbxBf+GsEje+vjbIzbo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu; spf=pass smtp.mailfrom=freemail.hu; dkim=fail (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b=jvt7JZkL reason="signature verification failed"; arc=none smtp.client-ip=46.107.16.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freemail.hu
Received: from [192.168.0.16] (catv-178-48-208-49.catv.fixed.vodafone.hu [178.48.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4XQ2mn4GPSzD8J;
	Fri, 11 Oct 2024 12:24:41 +0200 (CEST)
Message-ID: <264890a1-7234-407e-b7ba-078f32462afe@freemail.hu>
Date: Fri, 11 Oct 2024 12:23:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau/i2c: rename aux.c and aux.h to auxch.c and
 auxch.h
To: Lyude Paul <lyude@redhat.com>, bskeggs@nvidia.com, kherbst@redhat.com,
 airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240603091558.35672-1-egyszeregy@freemail.hu>
 <114482fe-0d91-4742-8ea1-5eaef8254c45@freemail.hu>
 <40b4b653e8c0c15343e211ff88ac8fe3f4d53e20.camel@redhat.com>
Content-Language: hu
From: =?UTF-8?Q?Sz=C5=91ke_Benjamin?= <egyszeregy@freemail.hu>
In-Reply-To: <40b4b653e8c0c15343e211ff88ac8fe3f4d53e20.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1728642282;
	s=20181004; d=freemail.hu;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	l=8454; bh=wmH4MV95rwYFIztY5AXfM1HAtK2mdhjrRiZSZ1fyGyI=;
	b=jvt7JZkLPIQ6RukzGrSHqrANt5slZDKVr7MCcTZk3XVh8rlmADWvccTnvoL7Joja
	exzlJxeZwQfIsPtQbOv7VSxxCqwHrt+OkAHeoqRhq3hmy+buUqmvpsxPtHGRM/U9a76
	KmF3kW39DsrugrYBUdcl/mHq0A8c0wap4I1362Zi+uHIZBSuMtU/LI8vzmRw5rCKuth
	mQ8QxAQQe4VUoux6iTpECTDVzJjTHiYh+uMswQqlfvh6CGhd6El5pYBxB2zz36OFyyS
	gSfNmIHJyCXUvhPbkAiEAREZSwynScVYylanCsTte4Ked3zCXjbuPAoRQn72MWvNuPQ
	VlZ82Shwrg==

2024. 10. 10. 23:17 keltezéssel, Lyude Paul írta:
> Hi - how did you send this message? This patch comes out looking quite strange
> on my machine, perhaps you don't have the encoding set to UTF-8 or aren't
> using git send-email?
> 
> On Mon, 2024-09-23 at 22:18 +0200, Szőke Benjamin wrote:
>> 	s=20181004; d=freemail.hu;
>> 	h=Message-ID:Date:MIME-Version:Subject:To:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
>> 	l=6727; bh=sJL9AOsUJH2ovHr5PYMU/rHzKoMeXVYsbJRkD0TaT5E=;
>> 	b=qY1DL1nlKnhWn0mpbbrefaus7g0fXuyQgL10k8YLW7EoFYdwaqOeDl6O+oQvVNmk
>> 	SvFiAJ5gdZeuP+2ZqTy3J1GOrOWP4HE77uQ4mJh9vyF3orZv2QtyIksudyXdHHiWwSS
>> 	IV7i4YkfUElv4+pFlUQ+hMRRXAOiqU/RVo1xBF0MBe/XGM1dt2UOj96u6lDp/vR7KP4
>> 	Tc7OCbj3h2I+07VEElEunHRpDFgZer+RV3SBLWBjiYBFtuUj3+iMnO/z36DlNJyHAj5
>> 	fySgG1IiRjIheKlzc5H7ikpMRfchALaeD+t1ayA7CERE4zDvIcBse8S5Oxkxvg7zwIW
>> 	Elv65cjloA==
>> Content-Transfer-Encoding: quoted-printable
>>
>> 2024. 06. 03. 11:15 keltez=C3=A9ssel, egyszeregy@freemail.hu =C3=ADrta:
>>> From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
>>> =20
>>> The goal is to clean-up Linux repository from AUX file names, because
>>> the use of such file names is prohibited on other operating systems
>>> such as Windows, so the Linux repository cannot be cloned and
>>> edited on them.
>>> =20
>>> Signed-off-by: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
>>> ---
>>>    drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild             | 2 +-
>>>    drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c          | 2 +-
>>>    drivers/gpu/drm/nouveau/nvkm/subdev/i2c/{aux.c =3D> auxch.c} | 2 +-
>>>    drivers/gpu/drm/nouveau/nvkm/subdev/i2c/{aux.h =3D> auxch.h} | 0
>>>    drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c           | 2 +-
>>>    drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c         | 2 +-
>>>    drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c         | 2 +-
>>>    drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c             | 2 +-
>>>    drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c           | 2 +-
>>>    drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c         | 2 +-
>>>    drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c         | 2 +-
>>>    11 files changed, 10 insertions(+), 10 deletions(-)
>>>    rename drivers/gpu/drm/nouveau/nvkm/subdev/i2c/{aux.c =3D> auxch.c} (=
>> 99%)
>>>    rename drivers/gpu/drm/nouveau/nvkm/subdev/i2c/{aux.h =3D> auxch.h} (=
>> 100%)
>>> =20
>>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild b/drivers/g=
>> pu/drm/nouveau/nvkm/subdev/i2c/Kbuild
>>> index 819703913a00..2c551bdc9bc9 100644
>>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild
>>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild
>>> @@ -25,7 +25,7 @@ nvkm-y +=3D nvkm/subdev/i2c/busnv50.o
>>>    nvkm-y +=3D nvkm/subdev/i2c/busgf119.o
>>>    nvkm-y +=3D nvkm/subdev/i2c/bit.o
>>>   =20
>>> -nvkm-y +=3D nvkm/subdev/i2c/aux.o
>>> +nvkm-y +=3D nvkm/subdev/i2c/auxch.o
>>>    nvkm-y +=3D nvkm/subdev/i2c/auxg94.o
>>>    nvkm-y +=3D nvkm/subdev/i2c/auxgf119.o
>>>    nvkm-y +=3D nvkm/subdev/i2c/auxgm200.o
>>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c b/driver=
>> s/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c
>>> index dd391809fef7..6c76e5e14b75 100644
>>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c
>>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c
>>> @@ -24,7 +24,7 @@
>>>    #define anx9805_pad(p) container_of((p), struct anx9805_pad, base)
>>>    #define anx9805_bus(p) container_of((p), struct anx9805_bus, base)
>>>    #define anx9805_aux(p) container_of((p), struct anx9805_aux, base)
>>> -#include "aux.h"
>>> +#include "auxch.h"
>>>    #include "bus.h"
>>>   =20
>>>    struct anx9805_pad {
>>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c b/drivers/gp=
>> u/drm/nouveau/nvkm/subdev/i2c/auxch.c
>>> similarity index 99%
>>> rename from drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c
>>> rename to drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxch.c
>>> index d063d0dc13c5..fafc634acbf6 100644
>>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c
>>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxch.c
>>> @@ -24,7 +24,7 @@
>>>   =20
>>>    #include <linux/string_helpers.h>
>>>   =20
>>> -#include "aux.h"
>>> +#include "auxch.h"
>>>    #include "pad.h"
>>>   =20
>>>    static int
>>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.h b/drivers/gp=
>> u/drm/nouveau/nvkm/subdev/i2c/auxch.h
>>> similarity index 100%
>>> rename from drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.h
>>> rename to drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxch.h
>>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c b/drivers=
>> /gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c
>>> index 47068f6f9c55..854bb4b5fdb4 100644
>>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c
>>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c
>>> @@ -22,7 +22,7 @@
>>>     * Authors: Ben Skeggs <bskeggs@redhat.com>
>>>     */
>>>    #define g94_i2c_aux(p) container_of((p), struct g94_i2c_aux, base)
>>> -#include "aux.h"
>>> +#include "auxch.h"
>>>   =20
>>>    struct g94_i2c_aux {
>>>    	struct nvkm_i2c_aux base;
>>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c b/drive=
>> rs/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c
>>> index dab40cd8fe3a..c17d5647cb99 100644
>>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c
>>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c
>>> @@ -19,7 +19,7 @@
>>>     * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
>>   OR
>>>     * OTHER DEALINGS IN THE SOFTWARE.
>>>     */
>>> -#include "aux.h"
>>> +#include "auxch.h"
>>>   =20
>>>    static const struct nvkm_i2c_aux_func
>>>    gf119_i2c_aux =3D {
>>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c b/drive=
>> rs/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c
>>> index 8bd1d442e465..3c5005e3b330 100644
>>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c
>>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c
>>> @@ -22,7 +22,7 @@
>>>     * Authors: Ben Skeggs <bskeggs@redhat.com>
>>>     */
>>>    #define gm200_i2c_aux(p) container_of((p), struct gm200_i2c_aux, base=
>> )
>>> -#include "aux.h"
>>> +#include "auxch.h"
>>>   =20
>>>    struct gm200_i2c_aux {
>>>    	struct nvkm_i2c_aux base;
>>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c b/drivers/g=
>> pu/drm/nouveau/nvkm/subdev/i2c/base.c
>>> index 976539de4220..ab86e11e7780 100644
>>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c
>>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c
>>> @@ -22,7 +22,7 @@
>>>     * Authors: Ben Skeggs
>>>     */
>>>    #include "priv.h"
>>> -#include "aux.h"
>>> +#include "auxch.h"
>>>    #include "bus.h"
>>>    #include "pad.h"
>>>   =20
>>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c b/drivers=
>> /gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c
>>> index 5904bc5f2d2a..cc26cd677917 100644
>>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c
>>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c
>>> @@ -22,7 +22,7 @@
>>>     * Authors: Ben Skeggs
>>>     */
>>>    #include "pad.h"
>>> -#include "aux.h"
>>> +#include "auxch.h"
>>>    #include "bus.h"
>>>   =20
>>>    void
>>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c b/drive=
>> rs/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c
>>> index 3bc4d0310076..1797c6c65979 100644
>>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c
>>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c
>>> @@ -22,7 +22,7 @@
>>>     * Authors: Ben Skeggs
>>>     */
>>>    #include "pad.h"
>>> -#include "aux.h"
>>> +#include "auxch.h"
>>>    #include "bus.h"
>>>   =20
>>>    static const struct nvkm_i2c_pad_func
>>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c b/drive=
>> rs/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c
>>> index 7d417f6a816e..5afc1bf8e798 100644
>>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c
>>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c
>>> @@ -22,7 +22,7 @@
>>>     * Authors: Ben Skeggs
>>>     */
>>>    #include "pad.h"
>>> -#include "aux.h"
>>> +#include "auxch.h"
>>>    #include "bus.h"
>>>   =20
>>>    static void
>>
>> @Ben Skeggs
>> When it will be merged? Your hints was done and ready in this renaming pa=
>> tch.
>>
> 

It was sent via git send-email and it used UTF-8 in default.

In the patch website there is no any problem about encoding looks good, please 
check your mailing client.
https://lore.kernel.org/all/4fbfe84b-c092-4648-819f-4368add9ec4a@nvidia.com/T/


