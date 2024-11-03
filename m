Return-Path: <linux-kernel+bounces-393713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F53E9BA44B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 07:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33F2828215F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 06:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618291531CB;
	Sun,  3 Nov 2024 06:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kode54.net header.i=@kode54.net header.b="T1WIDIig"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FDB3F9D5
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 06:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730615827; cv=none; b=kYDiB+RLbpAHs2SOJYY37McmE5JQD2SDS7pMXNom7jIPsI4PNZCxZNMkBtRCAf9hQXmlQ+LaEcBm/S/kZFwBTjEZ/8c6JD/pN6Oy3ZMa05/J4jM3jgtPP+SxWs06tTGHXI4Raz5wTOWtf0ujh4YZYv7fKlEg5bdGapA6FWbA72o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730615827; c=relaxed/simple;
	bh=GwgtCshqBBdn4aVHaFfxpYnFyhjtwDUZ/9No6s5ZkLo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=guALjLhF9ZdkD4Bot8XvHsBodkFsYOOtkMQCSE3zvpnkZ7lOeLVFNltELbVoU0JQHqI8lGUDuwoVQEZInkuHs29YqvirQ53HTZiA5R6SRILNCBHSBHVK3CqrJpJ3CIAZl80Qr+8rWiP9G/fblXJvcInRKrpt8vpdayFp4vgWO+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kode54.net; spf=pass smtp.mailfrom=kode54.net; dkim=pass (2048-bit key) header.d=kode54.net header.i=@kode54.net header.b=T1WIDIig; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kode54.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kode54.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kode54.net; s=key1;
	t=1730615821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hJsyO0aiVH3itRUzolMLYpvP9PbwpY9rZpdqz0+ihJA=;
	b=T1WIDIigSHP17EtdK4FALDzhmvpQd8rzVLraMfaT/1WCbTNUBsUGlUJUNsV+8iB6kczUDZ
	jB998dJNI2W4sbRjcObHGSuJyY1iG/f6NYW49aSsls+vQFfHamgMZ9Zb53seD06BOh/n3F
	xd64lSMWvHueJcYVwNzk/+6L5o8qJmMmY3g16bnWqFAdeDe8TPnd2faD8fCtkI+LTkn1fN
	q2M9ChhpfPwhFz89/T+AEgiOpCU81OxPYxVq5pYfnVWKOmcO8SWEmwi1vMr952hHSbNb+m
	+V44B1xFxspHdGyMqCIH/hN7r59h9szNQT2vmegOjwpIBjFc2Xnk7sFScpSmFw==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 02 Nov 2024 23:36:55 -0700
Message-Id: <D5CC3U00B7CG.IGKCIES8PC2J@kode54.net>
Cc: <kernel-dev@igalia.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH RESEND v9 1/2] drm/atomic: Let drivers decide which
 planes to async flip
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Christopher Snowhill" <chris@kode54.net>
To: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Harry
 Wentland" <harry.wentland@amd.com>, "Leo Li" <sunpeng.li@amd.com>, "Rodrigo
 Siqueira" <Rodrigo.Siqueira@amd.com>, "Alex Deucher"
 <alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Xinhui Pan" <Xinhui.Pan@amd.com>,
 <dmitry.baryshkov@linaro.org>, "Simon Ser" <contact@emersion.fr>,
 <joshua@froggi.es>, "Xaver Hugl" <xaver.hugl@gmail.com>, "Daniel Stone"
 <daniel@fooishbar.org>, <ville.syrjala@linux.intel.com>
References: <20241101-tonyk-async_flip-v9-0-681814efbfbe@igalia.com>
 <20241101-tonyk-async_flip-v9-1-681814efbfbe@igalia.com>
In-Reply-To: <20241101-tonyk-async_flip-v9-1-681814efbfbe@igalia.com>
X-Migadu-Flow: FLOW_OUT

On Fri Nov 1, 2024 at 11:23 AM PDT, Andr=C3=A9 Almeida wrote:
> Currently, DRM atomic uAPI allows only primary planes to be flipped
> asynchronously. However, each driver might be able to perform async
> flips in other different plane types. To enable drivers to set their own
> restrictions on which type of plane they can or cannot flip, use the
> existing atomic_async_check() from struct drm_plane_helper_funcs to
> enhance this flexibility, thus allowing different plane types to be able
> to do async flips as well.
>
> In order to prevent regressions and such, we keep the current policy: we
> skip the driver check for the primary plane, because it is always
> allowed to do async flips on it.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Should I do a R-b too? The changes looked sound enough for me to feel
like testing it as well. Tested Borderlands Game of the Year Enhanced on
my RX 7700 XT at maximum settings at 1080p165, and the tearing support in
labwc allowed it to reach over 700fps. No problems from the hardware
cursor.

Tested-by: Christopher Snowhill <chris@kode54.net>

> ---
> Changes from v8:
> - Rebased on top of 6.12-rc1
> ---
>  drivers/gpu/drm/drm_atomic_uapi.c | 39 +++++++++++++++++++++++++++++----=
------
>  1 file changed, 29 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atom=
ic_uapi.c
> index 370dc676e3aa543c9827b50df20df78f02b738c9..a0120df4b63e6b3419b53eb3d=
3673882559501c6 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -27,8 +27,9 @@
>   * Daniel Vetter <daniel.vetter@ffwll.ch>
>   */
> =20
> -#include <drm/drm_atomic_uapi.h>
>  #include <drm/drm_atomic.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_atomic_uapi.h>
>  #include <drm/drm_framebuffer.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_drv.h>
> @@ -1063,6 +1064,7 @@ int drm_atomic_set_property(struct drm_atomic_state=
 *state,
>  		struct drm_plane *plane =3D obj_to_plane(obj);
>  		struct drm_plane_state *plane_state;
>  		struct drm_mode_config *config =3D &plane->dev->mode_config;
> +		const struct drm_plane_helper_funcs *plane_funcs =3D plane->helper_pri=
vate;
> =20
>  		plane_state =3D drm_atomic_get_plane_state(state, plane);
>  		if (IS_ERR(plane_state)) {
> @@ -1070,15 +1072,32 @@ int drm_atomic_set_property(struct drm_atomic_sta=
te *state,
>  			break;
>  		}
> =20
> -		if (async_flip &&
> -		    (plane_state->plane->type !=3D DRM_PLANE_TYPE_PRIMARY ||
> -		     (prop !=3D config->prop_fb_id &&
> -		      prop !=3D config->prop_in_fence_fd &&
> -		      prop !=3D config->prop_fb_damage_clips))) {
> -			ret =3D drm_atomic_plane_get_property(plane, plane_state,
> -							    prop, &old_val);
> -			ret =3D drm_atomic_check_prop_changes(ret, old_val, prop_value, prop)=
;
> -			break;
> +		if (async_flip) {
> +			/* check if the prop does a nop change */
> +			if ((plane_state->plane->type !=3D DRM_PLANE_TYPE_PRIMARY) ||
> +			    (prop !=3D config->prop_fb_id &&
> +			     prop !=3D config->prop_in_fence_fd &&
> +			     prop !=3D config->prop_fb_damage_clips)) {
> +				ret =3D drm_atomic_plane_get_property(plane, plane_state,
> +								    prop, &old_val);
> +				ret =3D drm_atomic_check_prop_changes(ret, old_val, prop_value, prop=
);
> +				break;
> +			}
> +
> +			/* ask the driver if this non-primary plane is supported */
> +			if (plane->type !=3D DRM_PLANE_TYPE_PRIMARY) {
> +				ret =3D -EINVAL;
> +
> +				if (plane_funcs && plane_funcs->atomic_async_check)
> +					ret =3D plane_funcs->atomic_async_check(plane, state);
> +
> +				if (ret) {
> +					drm_dbg_atomic(prop->dev,
> +						       "[PLANE:%d] does not support async flips\n",
> +						       obj->id);
> +					break;
> +				}
> +			}
>  		}
> =20
>  		ret =3D drm_atomic_plane_set_property(plane,


