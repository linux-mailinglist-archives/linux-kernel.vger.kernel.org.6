Return-Path: <linux-kernel+bounces-312182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 485A6969324
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6AF01F22347
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 05:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF6C1CE6EA;
	Tue,  3 Sep 2024 05:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kode54.net header.i=@kode54.net header.b="Zw7NZtUs"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3831CEABF
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 05:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725340436; cv=none; b=lVAR3Fq3IMl0fUmJeptQ2b2rl3bg5YaLJRLwvFae4Nc2q2v4kXr9PeT50HKV4hcY5OhudsxmRqpMlgkxso0ynRlLSq7Y/uNc3KHIAJfkP4bhbZW3+NAoHHqnEKk0/xL1QmQK95AK2VydxMcSB5WqU+UzfFG5v9gSZFuZ6tmvE5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725340436; c=relaxed/simple;
	bh=f15Q/P/k20JWCads0V6SrXhPXYzjWoJbqK+xe3NkZ9E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RSz8glzEFJqf8gY+ClIpJnM33fxHZoYgdkl7oLYv+2O2Fe8C2Ouj/A31DC+iX4C4puzpdUnR/OnJmOTPuu87hDnVh4DirN1TiGdNui3etHMoJp5jYJkF00jYS7mJ99Qs984auBzfE/02wkXoGLa5gKcZkFtXh2vb+9q9lqbyIUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kode54.net; spf=pass smtp.mailfrom=kode54.net; dkim=pass (2048-bit key) header.d=kode54.net header.i=@kode54.net header.b=Zw7NZtUs; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kode54.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kode54.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kode54.net; s=key1;
	t=1725340430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iliSav6dNVEYXLM7O3mkTRt+jnvb6sFDnm4YjoTgLHY=;
	b=Zw7NZtUsZkfmlefxeuXz6WzKkI1OtfmSxdpPTXae4+Yi8LptdoYXzeeV8j2OqzZjSBTvEZ
	98cFj7eSAkoO1wo4IIxMgWDlTRNl0gJSt8RNF08uFHkgQMbgL1dfyRX3x5YtwMWzjcSoXt
	zPiPYsTRd3lSykDUqDOKJhC66DhmCPNmfObbkdgRiNkvZsySHrh3uMJLdX/JXbx71zex0q
	DLsfj9CPGwF6A5xLw6CmX0SVeH1AnpVztAO4NF+Z6pKx29N7bfj5q6UqiEJGR7udzauAwe
	5E8kpcIYbB4/qzeWWRNqghYC1b2SnihBrBxGaEC+0CxO107+8q/wI1snRPCxtg==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Sep 2024 22:13:43 -0700
Message-Id: <D3WE4WL0ZP0W.2S2CCR4UJ3Q5Z@kode54.net>
Cc: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm/amd/display: Avoid race between dcn10_set_drr()
 and dc_state_destruct()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Christopher Snowhill" <chris@kode54.net>
To: <tjakobi@math.uni-bielefeld.de>, "Harry Wentland"
 <harry.wentland@amd.com>, "Leo Li" <sunpeng.li@amd.com>, "Rodrigo Siqueira"
 <Rodrigo.Siqueira@amd.com>, "Alex Deucher" <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>, "David Airlie" <airlied@gmail.com>, "Daniel Vetter"
 <daniel@ffwll.ch>, "Mario Limonciello" <mario.limonciello@amd.com>
References: <cover.1725269643.git.tjakobi@math.uni-bielefeld.de>
 <7b9dbbbb1e6a3aa6d7a4d9367d44d18ddd947158.1725269643.git.tjakobi@math.uni-bielefeld.de>
In-Reply-To: <7b9dbbbb1e6a3aa6d7a4d9367d44d18ddd947158.1725269643.git.tjakobi@math.uni-bielefeld.de>
X-Migadu-Flow: FLOW_OUT

On Mon Sep 2, 2024 at 2:40 AM PDT, tjakobi wrote:
> From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>
> dc_state_destruct() nulls the resource context of the DC state. The pipe
> context passed to dcn10_set_drr() is a member of this resource context.
>
> If dc_state_destruct() is called parallel to the IRQ processing (which
> calls dcn10_set_drr() at some point), we can end up using already nulled
> function callback fields of struct stream_resource.
>
> The logic in dcn10_set_drr() already tries to avoid this, by checking tg
> against NULL. But if the nulling happens exactly after the NULL check and
> before the next access, then we get a race.
>
> Avoid this by copying tg first to a local variable, and then use this
> variable for all the operations. This should work, as long as nobody
> frees the resource pool where the timing generators live.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3142
> Fixes: 06ad7e164256 ("drm/amd/display: Destroy DC context while keeping D=
ML and DML2")
> Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> ---
>  .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 20 +++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/dr=
ivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> index 3306684e805a..da8f2cb3c5db 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> @@ -3223,15 +3223,19 @@ void dcn10_set_drr(struct pipe_ctx **pipe_ctx,
>  	 * as well.
>  	 */
>  	for (i =3D 0; i < num_pipes; i++) {
> -		if ((pipe_ctx[i]->stream_res.tg !=3D NULL) && pipe_ctx[i]->stream_res.=
tg->funcs) {
> -			if (pipe_ctx[i]->stream_res.tg->funcs->set_drr)
> -				pipe_ctx[i]->stream_res.tg->funcs->set_drr(
> -					pipe_ctx[i]->stream_res.tg, &params);
> +		/* dc_state_destruct() might null the stream resources, so fetch tg
> +		 * here first to avoid a race condition. The lifetime of the pointee
> +		 * itself (the timing_generator object) is not a problem here.
> +		 */
> +		struct timing_generator *tg =3D pipe_ctx[i]->stream_res.tg;
> +
> +		if ((tg !=3D NULL) && tg->funcs) {
> +			if (tg->funcs->set_drr)
> +				tg->funcs->set_drr(tg, &params);
>  			if (adjust.v_total_max !=3D 0 && adjust.v_total_min !=3D 0)
> -				if (pipe_ctx[i]->stream_res.tg->funcs->set_static_screen_control)
> -					pipe_ctx[i]->stream_res.tg->funcs->set_static_screen_control(
> -						pipe_ctx[i]->stream_res.tg,
> -						event_triggers, num_frames);
> +				if (tg->funcs->set_static_screen_control)
> +					tg->funcs->set_static_screen_control(
> +						tg, event_triggers, num_frames);
>  		}
>  	}
>  }

This fixes hard to trace panics with labwc VRR and Wayfire on RX 6700 XT. I=
 had to use netconsole to arrive at the original bug report.

Tested-by: Christopher Snowhill <chris@kode54.net>

