Return-Path: <linux-kernel+bounces-198747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5778D7CE0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA5E1F2192C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 07:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E0251C45;
	Mon,  3 Jun 2024 07:55:16 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991EB15E88;
	Mon,  3 Jun 2024 07:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717401316; cv=none; b=Ho0FD1AxBOgMkSicJASigmY5Ze00kzwONcM7yGAdVLNGwZ14w3LgsXDYI9muzBTaYo/LHcwS6R/fTgZFdPXirc0OerHDRG7xdfr7kbgv0Zii1zD+ci48KR42iLy/bAWu0QdsLqLG3utnN/Sftz7DdKECy+/f00GpohjtC1AxaBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717401316; c=relaxed/simple;
	bh=th5saVbuAdrVVqyrSVhx8SX8mhZfiEE25vFeKVYjz0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q1ScxAhBb9WO0/cu3XX+BSZHK/lNNTCRmTqnzW8WzReE0n8vVQA3ZdVkz9BAH0pAbVoXAxj+FekmsdZbFP7v7P2rIlDCqKke/M1RtS2x8JrH8NbHTpK4g00+LVHhMhUiu1RJj5EK0bgKRY94gM+JQCDoHPne8hdLiefxGy9r4nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-62a08092c4dso38261617b3.0;
        Mon, 03 Jun 2024 00:55:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717401313; x=1718006113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wZVMDSgC/t51F5hLY0RD85jq0qcUyuI6GoPOXg1j74=;
        b=dxlASCp2D7rKu7aHzMO+U4ewE7bonSnBS/BxcCrg8cJrpELERsRBsfURhYmH3T0+h8
         /4/bWXVvnSPMp+8r55YcqSofhTfQAjRDIdcy9YRT66/vZ3eZ+lCjfwuSF3g8NDBRu5mG
         //fMWWLwCKSqLR+RzfAZui+t16C3dtKbDPtzDX3+TT/sITnoqGmOL2ttLrfnLdb9VtVg
         SznScC42mj617AV0q+E6zUwDTwlj/zJxvgK8wC5WS7GFtIXbcLKt9lgYeRb1N0g/jiXc
         LeBvPVZpiB88FP3+SxKZeHQtUqlSF1TMd7j99PO2/LKjGZy5+x0QtZ8CszVm6ynTSjga
         pbLw==
X-Forwarded-Encrypted: i=1; AJvYcCUSJDAG5lkNOu2+fyQNksQ6J6sPttfimTulrVu1UBB91nhzGRrecFCGp77ZGLRLI+3U1XHDFX0O8e2sASW2znL+xxZGyN3AEZLC3zTDIfzYk56F+/hQt4tjt6kOPfIK/guV5Th0rYLdrJIpjVxo
X-Gm-Message-State: AOJu0Yy0yjoNYI50vNvKXUMxvzkOfzmPA4qKVML6FUm0ck9359sRXCTc
	AN4NRhwmU62oqBpEaE8eVjFM0rlzaWMJb3mD+h+9MsdP+cVIGcMn4zqsfiid
X-Google-Smtp-Source: AGHT+IE+roMHrs0pB6+NDlOTx2x2JHno7ocUjupffT3kA1n+QFi1rLzTC6DGN26LCJ8jnUolRc2uHQ==
X-Received: by 2002:a81:ae0b:0:b0:61c:8991:c20d with SMTP id 00721157ae682-62c79666d4dmr80609077b3.3.1717401313154;
        Mon, 03 Jun 2024 00:55:13 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62c766ad84fsm12631397b3.116.2024.06.03.00.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 00:55:13 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-df4d5d0b8d0so3510521276.2;
        Mon, 03 Jun 2024 00:55:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWmPnrJckBIpDBkG9H/+PcotVqwDpLGIpt13+ZhgUfYtaSQTgmeM8ccb84j8HtQp0WyPPZMiWS8gtLKRYQtgazWzwgSJKtttesJ160DI5UJD4Fug/zRMNxnkDi9wQ2wKuUI3WNDv6s3ghhw3O60
X-Received: by 2002:a25:a2c5:0:b0:dfa:96e4:f54d with SMTP id
 3f1490d57ef6-dfa96e4f95emr2769135276.41.1717401312832; Mon, 03 Jun 2024
 00:55:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602-md-drivers-auxdisplay-hd44780-v1-1-0f15bd19f949@quicinc.com>
In-Reply-To: <20240602-md-drivers-auxdisplay-hd44780-v1-1-0f15bd19f949@quicinc.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 3 Jun 2024 09:55:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWCTKBJ5FXeDTD+opJshNk3micT06kea+YRD7WTtqsnbg@mail.gmail.com>
Message-ID: <CAMuHMdWCTKBJ5FXeDTD+opJshNk3micT06kea+YRD7WTtqsnbg@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: hd44780: add missing MODULE_DESCRIPTION() macro
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 4:50=E2=80=AFAM Jeff Johnson <quic_jjohnson@quicinc.=
com> wrote:
> make allmodconfig && make W=3D1 C=3D1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/auxdisplay/hd44=
780_common.o
>
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

