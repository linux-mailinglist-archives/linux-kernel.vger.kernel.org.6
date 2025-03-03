Return-Path: <linux-kernel+bounces-541742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 130E6A4C10C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C0518897E6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A5C20F086;
	Mon,  3 Mar 2025 12:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FV9xelpT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E6D7DA6C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741006603; cv=none; b=jFkayybeOIcaGUDfvaHX6pqRrf717X09kGAqnh+/ZSpObRmQpGrFdRphGodhADlRyO8o41tid0AeUJ5bq83ARIZcmzX69f4FD4bJKew85QTOFnruscz6OzBJ07IJO8nKzjMhoM/iF38fijRkwafmsscu+Qpv09Ozj6zH+olQ+GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741006603; c=relaxed/simple;
	bh=UX3HfbY9NrbOd9tpd2P7hFNQCeHdeWclU4P4j4yWbwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljzV1XWslaeN0vaXxvWmeRo/gGqbkLgnk/9pB5Zp8dr8wcurnWBXEiV65pTMTK6VazYB0YyfJORc/UjS7UHiAVpB+mzUA5EmhvcHAt8TYEoZwtakliOjiVvYSv0NCVZjuVdOV2Q5SalfMusMz8Yq42wcW5i8txccak8P2epqd5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FV9xelpT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EE9C4CEED
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 12:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741006602;
	bh=UX3HfbY9NrbOd9tpd2P7hFNQCeHdeWclU4P4j4yWbwI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FV9xelpTeEOVh2F9LLHt7cZEamR97RqTHhg+X8WoBEYkAdzKYDoMPFGtFf8M90C3D
	 TKgWlwqQHfV9WGMud0bBw2UL2qbO5ucIGnrIH98qUmbbmVpcNd09anXw7cMKWrYT9C
	 xgsT0eOnRDvogmt97w/5hTiDGDBb4QDrgD0AcjuZD2W2vQV8Zt5itjsBOfSVnOEkDz
	 u1V0SEBZvaUbFO0watcpspU5ainokC0giq5omDV1ZcV20THn1iLL/F1LeXjaAyJt+M
	 8VCklBlAsyFYjeFHSOAowTLy2dqy+W20cxyVfJkhIw1AKmlvdPpprIuf32RtQgeEJB
	 MXlpfnsRQml6A==
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fea8d8c322so7916951a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 04:56:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWYpkB3GTXfwO0ACxTCTxVZMY+NP4/F5dm2ZxnqZF2OUC2uRJYnK/ms2s3qDLzvp8WqvAkERmNQk6NmknY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Uanu6J48/8lK7UPFgjvUm6Owhc9zHm5wsZ9R4f5Obw18y/3q
	gJaRnAOzlppYKwMlbksGCnYG/YyEV5BoKYEtNnjxzd/XvFyn+5DQc0fOxVjAnJaKzCkVqjyZMJe
	XprXBotc1bBewcGTm022LmflpTw==
X-Google-Smtp-Source: AGHT+IGSSgSzh55HSnQ1lVjwMdzp28MHDOUOnEh8kdGeJHmMnwiYf8Q6NzYRnemJliLplJUfJXLVhNNZXMjP1z0RvT8=
X-Received: by 2002:a17:90b:3511:b0:2ee:8427:4b02 with SMTP id
 98e67ed59e1d1-2febabd9c82mr19809852a91.28.1741006602131; Mon, 03 Mar 2025
 04:56:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224051301.3538484-1-jason-jh.lin@mediatek.com>
In-Reply-To: <20250224051301.3538484-1-jason-jh.lin@mediatek.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Mon, 3 Mar 2025 20:57:29 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8cGVEYV2v6oAHHnVqfjk3jp_a1QtaYJRqDf1Hg4vY0UA@mail.gmail.com>
X-Gm-Features: AQ5f1Jred4c1pw-7JgOxVG6xQG08SC8yxuC59gWdugp16YcFov8bdecIzf41xyo
Message-ID: <CAAOTY_8cGVEYV2v6oAHHnVqfjk3jp_a1QtaYJRqDf1Hg4vY0UA@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Fix config_updating flag never false when
 no mbox channel
To: Jason-JH Lin <jason-jh.lin@mediatek.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Nancy Lin <nancy.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, 
	Yongqiang Niu <yongqiang.niu@mediatek.com>, Sirius Wang <sirius.wang@mediatek.com>, 
	Xavier Chang <xavier.chang@mediatek.com>, Fei Shao <fshao@chromium.org>, 
	Chen-yu Tsai <wenst@chromium.org>, Pin-yen Lin <treapking@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jason:

Jason-JH Lin <jason-jh.lin@mediatek.com> =E6=96=BC 2025=E5=B9=B42=E6=9C=882=
4=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=881:13=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> When CONFIG_MTK_CMDQ is enabled, if the display is controlled by the CPU
> while other hardware is controlled by the GCE, the display will encounter
> a mbox request channel failure.
> However, it will still enter the CONFIG_MTK_CMDQ statement, causing the
> config_updating flag to never be set to false. As a result, no page flip
> event is sent back to user space, and the screen does not update.

Applied to mediatek-drm-next [1], thanks.

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.=
git/log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Fixes: da03801ad08f ("drm/mediatek: Move mtk_crtc_finish_page_flip() to d=
dp_cmdq_cb()")
> Signed-off-by: Jason-JH Lin <jason-jh.lin@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_crtc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediat=
ek/mtk_crtc.c
> index 5674f5707cca..cfc4867296b8 100644
> --- a/drivers/gpu/drm/mediatek/mtk_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
> @@ -620,13 +620,14 @@ static void mtk_crtc_update_config(struct mtk_crtc =
*mtk_crtc, bool needs_vblank)
>
>                 mbox_send_message(mtk_crtc->cmdq_client.chan, cmdq_handle=
);
>                 mbox_client_txdone(mtk_crtc->cmdq_client.chan, 0);
> +               goto update_config_out;
>         }
> -#else
> +#endif
>         spin_lock_irqsave(&mtk_crtc->config_lock, flags);
>         mtk_crtc->config_updating =3D false;
>         spin_unlock_irqrestore(&mtk_crtc->config_lock, flags);
> -#endif
>
> +update_config_out:
>         mutex_unlock(&mtk_crtc->hw_lock);
>  }
>
> --
> 2.43.0
>

