Return-Path: <linux-kernel+bounces-516500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98663A37297
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 09:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4085516DC22
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 08:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B6F1624C0;
	Sun, 16 Feb 2025 08:39:45 +0000 (UTC)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E26366;
	Sun, 16 Feb 2025 08:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739695185; cv=none; b=ENJ4ZO4UvKjE3trsechM4nTLlBVLwjyDiJqpir4vJ22N168oYYVsugZ4/2nRTLkNtR4R8utIJ0rYNcQMePTKsd67L7tzxEEt1xlVykcKRO56PCjNPWaFT6ix6PKypdY13Zf1SIx5b4kxWhtcTEfCUtk/ZP9Gv71VVwqVF8fw2Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739695185; c=relaxed/simple;
	bh=4AdpC+R4N8zDGtraiU5Lmy5Fens0u4reg+EHPOLw5QQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I+cwFfTOVAUO4oPdmXcY73xC2Jp3Eq44PY92ZZX4ecjeUyObgAoOsmjV11eEVEaWqehoe6kVKtOQEOn0y7zAgEq+MYEyf0cVaQeE8NR86nNcPMTnpUNSpPjALqPVGGAR0VUPqgAMq5QgRG62vvoxmo0DZkg0Wp+J3uCwwNBgv/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5452e6f2999so2082116e87.3;
        Sun, 16 Feb 2025 00:39:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739695180; x=1740299980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4AdpC+R4N8zDGtraiU5Lmy5Fens0u4reg+EHPOLw5QQ=;
        b=MGpnjBJ5AzXn+N1snrgZCa44PBO9kLGheBOhwQw8v81xMlFzmlQbrcyEZlzxRwDvpB
         OE1o7J2k2XJK19oJmApw5ProBJBMXK7R/NYzf4l6PraD4hoKaHUAFWnG5tAOQO3e1sGr
         47q2fHjhDNCud7OKflvzYdHo9zLaSYSaRoGo35wF8ea2wTNymUjZLZ/gAMQLG3FyXbYz
         /C4/572XpEHLjujRXIDYAOrmXR8z0i9CDMrAbUsu6QaK3pXklGqaUoVnWdGrZqjQjUG5
         l5L97jiTAS1V0woV1dF0RNhLbRU/umjDrLC8npjgtPEYyfAm72s0G930ElhXtI5Gv4RA
         3hFg==
X-Forwarded-Encrypted: i=1; AJvYcCUY1qnFBQxfCuED4I9cGs9m1QSmV4HTmbAcQOicabMP7TfZ0iYyxy8a3WPXUNFgvrMPkSBkEBUnPt+AKrCd@vger.kernel.org, AJvYcCVP83K+qmUV0ZvanX0eviYaEsFD81ESmbc4NZrwq5TjbtYsOB9yKQ7QdCLJzB4WILbvpDZ0/EOaV6AZ@vger.kernel.org, AJvYcCXA0Dzh9Kx3VQ3ZEsMLMA76CzD+2RRcKnVB5HnR9G+bE/BLJpRaQl2YE4McJ9I6qYVz6xblD7mazSJX@vger.kernel.org
X-Gm-Message-State: AOJu0YwsLs3hGUELAWFBqCZe409ZD+xMeWA5KErW9T7iJnS/loZ+BPy+
	i4E4R5VvG3nv50WhRK2QBUXzzKmQ60LS1h2LGeYzG3k7HKLsxfTwTd4YUK+0
X-Gm-Gg: ASbGncsZsFbmIlh5ymwFvDhQS74pFoi676VDKVOzDXRawOTf4fHdk1OQeKXL7YUeyD8
	3d1en8YeojXj55Fh0dpZQ672qeU5ZHb6THLoW0hnRhk8dRaklk2lTUx7GzKeFKmf/dSWsgMVq6M
	IfrD/34lnO4chAojDESXsPIDsnYEvLaWqBRwM2xhhRzL+/RDr4CFjd3/UEDOTf1ecKw6qrzdgEM
	kSlXWIZraYTOhZS2FtwpDdqnhP1/QpYLJEv7MdcOv3F/ZBaV6J3lcwrc80dxRDCCONu9q+aHQAY
	XayCJ4Pz4qQqSlaofyTb9qzsENuEGzUrfvbgKvyvVSHd
X-Google-Smtp-Source: AGHT+IGi6HSZ15pKWDKtvPTrzf8HgZrjGvL683De67Zoo2HECa8ObjO+rp+gOfKhA05iXSjPGFCHvQ==
X-Received: by 2002:a05:6512:3992:b0:542:98bb:5674 with SMTP id 2adb3069b0e04-5452fe6b1damr1580131e87.33.1739695179458;
        Sun, 16 Feb 2025 00:39:39 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54618f83486sm276060e87.140.2025.02.16.00.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 00:39:38 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-545316f80beso816490e87.1;
        Sun, 16 Feb 2025 00:39:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1DQPQiRVgjWeLF91QPsG4xqveo9SvR0kvGd6+iscjK6cTr+0MH/4R4fBPNL9a/kxZnQmFXZ/zfcEZ@vger.kernel.org, AJvYcCWa1NTjzMDamYzeEFzMUVZBxyko9YfWpm9as6C3G6CD11QBQDMiZAKxz6W7XC8UPrA6RyuCH2wj4sgQ@vger.kernel.org, AJvYcCWviGvn5t45O8z14XCFAmFLsNdSHzjZTXpKaf7jlAgKGfDG5Nl9AxlC3wgV6q0SWFYpvN0GiiiU3JW67EQw@vger.kernel.org
X-Received: by 2002:a05:6512:3b0b:b0:545:c89:2bb4 with SMTP id
 2adb3069b0e04-5452fe3a9a4mr1513881e87.23.1739695178124; Sun, 16 Feb 2025
 00:39:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214125359.5204-1-andre.przywara@arm.com> <20250214125359.5204-2-andre.przywara@arm.com>
In-Reply-To: <20250214125359.5204-2-andre.przywara@arm.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sun, 16 Feb 2025 16:39:25 +0800
X-Gmail-Original-Message-ID: <CAGb2v66q0mymn9a0uy5zyYCOKiLV+WACkM6SHoy057u-F9vstA@mail.gmail.com>
X-Gm-Features: AWEUYZlJN5fyyQqJMaZNefcoToyMAqIjjxYWZyhvGNhYIbG8A1i9T2wmnDZTFAc
Message-ID: <CAGb2v66q0mymn9a0uy5zyYCOKiLV+WACkM6SHoy057u-F9vstA@mail.gmail.com>
Subject: Re: [PATCH v2 01/15] clk: sunxi-ng: mp: Add SUNXI_CCU_P_DATA_WITH_MUX_GATE
 wrapper
To: Andre Przywara <andre.przywara@arm.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 8:56=E2=80=AFPM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> The PRCM CCU in the A523 SoC contains some clocks that only feature a
> P (shift) factor, but no M divider.
> Treat this as a special case of an MP clock: by forcing the M mask to be
> 0 bits wide, this always result in the M divider value to be 1.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

