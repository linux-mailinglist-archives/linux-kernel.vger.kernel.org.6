Return-Path: <linux-kernel+bounces-538103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AECAA4949B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66EB0170ECB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE1824A07F;
	Fri, 28 Feb 2025 09:17:56 +0000 (UTC)
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [5.144.164.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D626F24A046
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734276; cv=none; b=LajeoRdEjvHuWL5eNQJ14g9jsJBpPm1Y5eNyILVDoafcB5ya1LErYFakzvp/In7Av5KwNSf82IDcOo3PxfkH4dbajMdcPn2DiBhbN6X32UkyQXWAZudEzarzOjp0ja7CFAoebbxa9O9WUDqxIhZPZDg/7IOil/cJnpTxk5Vvz+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734276; c=relaxed/simple;
	bh=UWrasMPhZgBN8iz+xsk13yZ0dRriDkIlfknmsEWbDn8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=qrYgFo6CFBMHD4C/+oUx7T5SyQBWlGx9pA+MlRiNBSL8f5mzSJa+5WUbHlOhBsSe7uj6HAU0zZ8uM9Pozw8PbqEaQ0oZrMHmElszTcgbATdgR3NBKHLQBICQ5/o419uz9PLP7PgwANILexqpexak6rL3uprpsCjwWfDFJejJ+oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from [127.0.0.1] (161-51-78-170.static.ef-service.nl [161.51.78.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 13C6D3EE67;
	Fri, 28 Feb 2025 10:08:48 +0100 (CET)
Date: Fri, 28 Feb 2025 10:08:47 +0100
From: Marijn Suijten <marijn.suijten@somainline.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
CC: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_8/8=5D_drm/msm/dpu=3A_drop_n?=
 =?US-ASCII?Q?ow-unused_condition_for_has=5Flegacy=5Fctls?=
User-Agent: Thunderbird for Android
In-Reply-To: <20250228-dpu-active-ctl-v2-8-9a9df2ee5193@linaro.org>
References: <20250228-dpu-active-ctl-v2-0-9a9df2ee5193@linaro.org> <20250228-dpu-active-ctl-v2-8-9a9df2ee5193@linaro.org>
Message-ID: <CA752964-870A-4DB9-A6F7-0E701EA24AB2@somainline.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28 February 2025 05:14:12 CET, Dmitry Baryshkov <dmitry=2Ebaryshkov@lina=
ro=2Eorg> wrote:
>Now as we have dropped the DPU_CTL_SPLIT_DISPLAY from DPU >=3D 5=2E0
>configuration, drop the rm->has_legacy_ctl condition which short-cutted
>the check for those platforms=2E
>
>Suggested-by: Marijn Suijten <marijn=2Esuijten@somainline=2Eorg>
>Signed-off-by: Dmitry Baryshkov <dmitry=2Ebaryshkov@linaro=2Eorg>
>
>---
>
>Note, it is imposible to reoder commits in any other sensible way=2E The

Reorder :)

>DPU_CTL_SPLIT_DISPLAY can not be dropped before the patch that enables
>single-CTL support=2E

Maybe I expected this note on patch 4/6 introducing it, but it disappears =
after merging anyway so that's a mega-nit=2E Thanks for sending this!

Reviewed-by: Marijn Suijten <marijn=2Esuijten@somainline=2Eorg>

>---
> drivers/gpu/drm/msm/disp/dpu1/dpu_rm=2Ec | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm=2Ec b/drivers/gpu/drm/m=
sm/disp/dpu1/dpu_rm=2Ec
>index 4dbc9bc7eb4f151f83055220665ee5fd238ae7ba=2E=2E2557effe639b5360bc948=
a49b0cccdb59ee35dab 100644
>--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm=2Ec
>+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm=2Ec
>@@ -410,8 +410,7 @@ static int _dpu_rm_reserve_ctls(
>=20
> 		DPU_DEBUG("ctl %d caps 0x%lX\n", j + CTL_0, features);
>=20
>-		if (rm->has_legacy_ctls &&
>-		    needs_split_display !=3D has_split_display)
>+		if (needs_split_display !=3D has_split_display)
> 			continue;
>=20
> 		ctl_idx[i] =3D j;
>


