Return-Path: <linux-kernel+bounces-336293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2758D97F1AE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 22:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2F012823D3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 20:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D831A0BC0;
	Mon, 23 Sep 2024 20:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b="qY1DL1nl"
Received: from smtp-out.freemail.hu (fmfe01.freemail.hu [46.107.16.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EE215E86
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 20:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.107.16.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727123163; cv=none; b=etawXXlsVoDa4oqkyEmfSOxukQncxWGd1pBkwtCEicwzQit48uiLmfEDCI+715lcwpB8R8avwqkIjYc1v7gs+8ba7M092dvkGQglTmFDhFmWbCc+Naj9rAe4qjewnShy+fDzxbtEnEf3UoPDq7WzKmBXI7KlmQyWZ9TQBnje7q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727123163; c=relaxed/simple;
	bh=uLwyq7xDuxysaj8RDlTAR4VUmlz34Mci72w0JJh86GM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hNeHteOumSmDl+2rLYyVzK/c5WEOMzZcpB81BPjnsi0fU+M121CPcxRJHqRkOxkGxNsGkdkTgALqq6qycDMURn3fWqCCY7SunRvFCr+AJDJtUnlH4qk4f4G6OW1DlDkOoPsGluOBbiOmunNqbQOLFWuAGtjWu/EW/IcNb09MFyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu; spf=pass smtp.mailfrom=freemail.hu; dkim=fail (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b=qY1DL1nl reason="signature verification failed"; arc=none smtp.client-ip=46.107.16.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freemail.hu
Received: from [192.168.0.16] (catv-178-48-208-49.catv.fixed.vodafone.hu [178.48.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4XCDq658Pkz6b9;
	Mon, 23 Sep 2024 22:19:14 +0200 (CEST)
Message-ID: <114482fe-0d91-4742-8ea1-5eaef8254c45@freemail.hu>
Date: Mon, 23 Sep 2024 22:18:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau/i2c: rename aux.c and aux.h to auxch.c and
 auxch.h
To: bskeggs@nvidia.com, kherbst@redhat.com, lyude@redhat.com,
 airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240603091558.35672-1-egyszeregy@freemail.hu>
Content-Language: hu
From: =?UTF-8?Q?Sz=C5=91ke_Benjamin?= <egyszeregy@freemail.hu>
In-Reply-To: <20240603091558.35672-1-egyszeregy@freemail.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1727122755;
	s=20181004; d=freemail.hu;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	l=6727; bh=sJL9AOsUJH2ovHr5PYMU/rHzKoMeXVYsbJRkD0TaT5E=;
	b=qY1DL1nlKnhWn0mpbbrefaus7g0fXuyQgL10k8YLW7EoFYdwaqOeDl6O+oQvVNmk
	SvFiAJ5gdZeuP+2ZqTy3J1GOrOWP4HE77uQ4mJh9vyF3orZv2QtyIksudyXdHHiWwSS
	IV7i4YkfUElv4+pFlUQ+hMRRXAOiqU/RVo1xBF0MBe/XGM1dt2UOj96u6lDp/vR7KP4
	Tc7OCbj3h2I+07VEElEunHRpDFgZer+RV3SBLWBjiYBFtuUj3+iMnO/z36DlNJyHAj5
	fySgG1IiRjIheKlzc5H7ikpMRfchALaeD+t1ayA7CERE4zDvIcBse8S5Oxkxvg7zwIW
	Elv65cjloA==

2024. 06. 03. 11:15 keltezéssel, egyszeregy@freemail.hu írta:
> From: Benjamin Szőke <egyszeregy@freemail.hu>
> 
> The goal is to clean-up Linux repository from AUX file names, because
> the use of such file names is prohibited on other operating systems
> such as Windows, so the Linux repository cannot be cloned and
> edited on them.
> 
> Signed-off-by: Benjamin Szőke <egyszeregy@freemail.hu>
> ---
>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild             | 2 +-
>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c          | 2 +-
>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/{aux.c => auxch.c} | 2 +-
>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/{aux.h => auxch.h} | 0
>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c           | 2 +-
>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c         | 2 +-
>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c         | 2 +-
>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c             | 2 +-
>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c           | 2 +-
>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c         | 2 +-
>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c         | 2 +-
>   11 files changed, 10 insertions(+), 10 deletions(-)
>   rename drivers/gpu/drm/nouveau/nvkm/subdev/i2c/{aux.c => auxch.c} (99%)
>   rename drivers/gpu/drm/nouveau/nvkm/subdev/i2c/{aux.h => auxch.h} (100%)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild
> index 819703913a00..2c551bdc9bc9 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/Kbuild
> @@ -25,7 +25,7 @@ nvkm-y += nvkm/subdev/i2c/busnv50.o
>   nvkm-y += nvkm/subdev/i2c/busgf119.o
>   nvkm-y += nvkm/subdev/i2c/bit.o
>   
> -nvkm-y += nvkm/subdev/i2c/aux.o
> +nvkm-y += nvkm/subdev/i2c/auxch.o
>   nvkm-y += nvkm/subdev/i2c/auxg94.o
>   nvkm-y += nvkm/subdev/i2c/auxgf119.o
>   nvkm-y += nvkm/subdev/i2c/auxgm200.o
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c
> index dd391809fef7..6c76e5e14b75 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/anx9805.c
> @@ -24,7 +24,7 @@
>   #define anx9805_pad(p) container_of((p), struct anx9805_pad, base)
>   #define anx9805_bus(p) container_of((p), struct anx9805_bus, base)
>   #define anx9805_aux(p) container_of((p), struct anx9805_aux, base)
> -#include "aux.h"
> +#include "auxch.h"
>   #include "bus.h"
>   
>   struct anx9805_pad {
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxch.c
> similarity index 99%
> rename from drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c
> rename to drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxch.c
> index d063d0dc13c5..fafc634acbf6 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxch.c
> @@ -24,7 +24,7 @@
>   
>   #include <linux/string_helpers.h>
>   
> -#include "aux.h"
> +#include "auxch.h"
>   #include "pad.h"
>   
>   static int
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.h b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxch.h
> similarity index 100%
> rename from drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.h
> rename to drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxch.h
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c
> index 47068f6f9c55..854bb4b5fdb4 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxg94.c
> @@ -22,7 +22,7 @@
>    * Authors: Ben Skeggs <bskeggs@redhat.com>
>    */
>   #define g94_i2c_aux(p) container_of((p), struct g94_i2c_aux, base)
> -#include "aux.h"
> +#include "auxch.h"
>   
>   struct g94_i2c_aux {
>   	struct nvkm_i2c_aux base;
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c
> index dab40cd8fe3a..c17d5647cb99 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgf119.c
> @@ -19,7 +19,7 @@
>    * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>    * OTHER DEALINGS IN THE SOFTWARE.
>    */
> -#include "aux.h"
> +#include "auxch.h"
>   
>   static const struct nvkm_i2c_aux_func
>   gf119_i2c_aux = {
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c
> index 8bd1d442e465..3c5005e3b330 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/auxgm200.c
> @@ -22,7 +22,7 @@
>    * Authors: Ben Skeggs <bskeggs@redhat.com>
>    */
>   #define gm200_i2c_aux(p) container_of((p), struct gm200_i2c_aux, base)
> -#include "aux.h"
> +#include "auxch.h"
>   
>   struct gm200_i2c_aux {
>   	struct nvkm_i2c_aux base;
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c
> index 976539de4220..ab86e11e7780 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c
> @@ -22,7 +22,7 @@
>    * Authors: Ben Skeggs
>    */
>   #include "priv.h"
> -#include "aux.h"
> +#include "auxch.h"
>   #include "bus.h"
>   #include "pad.h"
>   
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c
> index 5904bc5f2d2a..cc26cd677917 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padg94.c
> @@ -22,7 +22,7 @@
>    * Authors: Ben Skeggs
>    */
>   #include "pad.h"
> -#include "aux.h"
> +#include "auxch.h"
>   #include "bus.h"
>   
>   void
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c
> index 3bc4d0310076..1797c6c65979 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgf119.c
> @@ -22,7 +22,7 @@
>    * Authors: Ben Skeggs
>    */
>   #include "pad.h"
> -#include "aux.h"
> +#include "auxch.h"
>   #include "bus.h"
>   
>   static const struct nvkm_i2c_pad_func
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c
> index 7d417f6a816e..5afc1bf8e798 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/padgm200.c
> @@ -22,7 +22,7 @@
>    * Authors: Ben Skeggs
>    */
>   #include "pad.h"
> -#include "aux.h"
> +#include "auxch.h"
>   #include "bus.h"
>   
>   static void

@Ben Skeggs
When it will be merged? Your hints was done and ready in this renaming patch.

