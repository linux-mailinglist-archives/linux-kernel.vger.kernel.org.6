Return-Path: <linux-kernel+bounces-553886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1C0A59031
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D606B3A3260
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368FA2253FB;
	Mon, 10 Mar 2025 09:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="jevzH2MB";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="O5QlY+v/"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF193224B01
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600148; cv=none; b=hmD++j2w1o4FxR7DlJzb6oPX9viuA5cY5Hv4pA0opI/QkEC6Z2d5jGwpW/Tj6nHeaRuIOtzOzhtikRDjQ2TUWeUxIR6cDD2sOU6WWy5BTzEEsfVtAg9AT2Jpd7g4hsLRc2bnXMOxKJ+8erqR93nYzg27u34/0XnFXQVqWefYXhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600148; c=relaxed/simple;
	bh=KGzohucEibfvFwIp97ECwF+iQRBdnGsGxWwIsbPjQwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikwA1Dot4edL4dv9pfrtAepF/3iYMHWS+dw4NaHu7Di9gafVvEakMAWl967B19Pr02BzOoleHiNqJZUKgPRSA9nHZ8BggD/HjiMz5kpwrEmoi9iiGSjsZBVoQXAXuio3XZTBxv1kqU4wCRbJuIjgcnVf6yy76FxKXWkjEJk9KFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=jevzH2MB; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=O5QlY+v/; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1741600145;
	bh=KGzohucEibfvFwIp97ECwF+iQRBdnGsGxWwIsbPjQwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jevzH2MBu7sVcyHublF35nP6u0fgGDvi9j2H5NpntXdLZzwg4QwoFtzlNTH98899z
	 uhXivfdZ3jPFi2Dn22psiisj82vNfeWILjGv1wztyqHPtU0yWqrPR/R6aDVdxEu+su
	 BNdkYiMfbrzu6U8gHY7AxCUSedw53BKgRHMArVdK2k8sVAsIYnfeV5kOyNU11PHwA+
	 HtZv9Q+Xik0GZ1HHzpRvU5LWcut03a74wdIF5VowQMQ01+l//3PbF2bdSFcA0IvMl0
	 FljKGIVuXEeLns03bAuzXRl58ZjmScKHujFC/7n/fBN0xJqxpHEhhD24X9JRZL4789
	 78pj0QiJj90eQ==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id 6B1E63F7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 18:49:05 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=O5QlY+v/;
	dkim-atps=neutral
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id E5F11370
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 18:49:03 +0900 (JST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2241e7e3addso55639445ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1741600143; x=1742204943; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cMplhkU7/xNaLivbH/tAX85wd7GEF5imHf27QWWTOFA=;
        b=O5QlY+v/zvVRSMpZZ0ZZBkTBI527vz953FnxiFiF/6qD9zlBk4xmuL5bIS+1/QRh9S
         WJMWBQaO/ZtS990IzbcMTvwXKmr7E2hYxFX63pI2QRuGaPnRSrrRJT+qQrdq+AAj+5fC
         16o5VwWeNw0KmEddtB8k3r3bb9X/Q2cOMPPF+pgl56mT7a/+BP5fyXtgH8htIW0awvzU
         yeZzya+DV7JXD10zCBDh6wZpCHlyGDjJionHIqF/eH201crXeICbOdN/m0W4nBYjhOzO
         gmbjG9yLjadZPPH9UtWPSdFxsEGDLwjP9bDoCAKte4DL+7Xy76GEEBQWm4RneNtNs2Xa
         cNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741600143; x=1742204943;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cMplhkU7/xNaLivbH/tAX85wd7GEF5imHf27QWWTOFA=;
        b=HlVvtj2L9rULzQQI+kgDIFlt9DOxw5nzw0edEoXBGEmFhGOgqd5kMnk5Ubk5WWkrA1
         89UIB2rhU5Sz0LKTMvrfc84v8inJa7OM9daHLFDUz9x/mWgyRBH/ArjzJm163Yg8CZZk
         oAskbvkOKCvbwMKIWOVDiPiV78xjPHe7AuVS5fGeIBJm4ZI79OzpsI+9tiWStoAeJb0l
         dmMD7jZhPJDc+EFdixge7mxRBV5Z25/LpTHLrQzYljRTd1ktQxMhV/VurtYdTpd4tiDw
         l1iW9DXVFF0KazS3v9UkUAqq3L5fcf1l8mFGKqAqAsh143Ykxawmgt8MHxqAG/8g7qG9
         EPkg==
X-Forwarded-Encrypted: i=1; AJvYcCXgwT/4R7hDTcOI9mGJG0SS2KSVXiffaWup3ROoPbG0TLSU+HjcgRrVfM7MaiqjQshKueEAaapxqPrN29c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2e99i7IpHLNM3w49jcC7lXnJ31lejG0p+0k4rlgdXcI/rUYI3
	suM0nKFnpx6lt362JNARkKOEiRFeCNqgvcMPDybOMmom5KlQh4MtKZqE5T1fhxyI8Kdd8bPQha/
	go8kX7MNn3DAtPCt5hW9Qtoc3QbbqHK3I5/ULlRx9M6UMOzMWuFs16jkLFloJpQE=
X-Gm-Gg: ASbGncvyurUFT7xReGU6BKnL8zML8TLz5o+2cUBtCm+0mhDMFerUcuUtSvFsnUo7ngj
	DsvDgp2TIt+6BoQN2StHJTc7igMiPdrDHRMg94hWN0cBlKxHTjwzKIIiiKj7Kka+OGwYmKfRz6K
	jLogkRzoNxn6BGc9UsO6VilcE1iqc7pa77VvHtTW+UH/sPxzvIqIkzMtSjcsjOFbToLei44iIVX
	xr/ogZ71k6aQfy/DWTCnpLEwXBXWCencG6shHbHUg1I/dx5jIl51IBf5SjT3m309Peq6Nz7OUvE
	QARArsGtJl2IVEm8dp9baCHJn++aQSGdlicHHZms+kqLz5BTJqsX51cgfYRe6lH3ZymJxaXMfrY
	=
X-Received: by 2002:a17:902:ecc1:b0:21a:8300:b9ce with SMTP id d9443c01a7336-22428bf713dmr204108835ad.49.1741600142941;
        Mon, 10 Mar 2025 02:49:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzmx6Y1Fxp6z5swFdmpzUwVPgfshZGQMemlhj3ID1HbhozKrpzs4J3HbD5rqkDcthfR80x+w==
X-Received: by 2002:a17:902:ecc1:b0:21a:8300:b9ce with SMTP id d9443c01a7336-22428bf713dmr204108565ad.49.1741600142612;
        Mon, 10 Mar 2025 02:49:02 -0700 (PDT)
Received: from localhost (162.198.187.35.bc.googleusercontent.com. [35.187.198.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f747sm73205405ad.127.2025.03.10.02.49.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Mar 2025 02:49:02 -0700 (PDT)
Date: Mon, 10 Mar 2025 18:48:50 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Adam Ford <aford173@gmail.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Lucas Stach <l.stach@pengutronix.de>, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Makoto Sato <makoto.sato@atmark-techno.com>
Subject: Re: [PATCH] phy: freescale: fsl-samsung-hdmi: return closest rate
 instead LUT
Message-ID: <Z861gsaGY6bGSisf@atmark-techno.com>
References: <20250310-8ulp_hdmi-v1-1-a2f231e31987@atmark-techno.com>
 <v57uy3gddzcoeg3refyv7h6j3ypx23mobctybt27xzdyqy6bgb@atzdlqlytz3c>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <v57uy3gddzcoeg3refyv7h6j3ypx23mobctybt27xzdyqy6bgb@atzdlqlytz3c>

Uwe Kleine-König wrote on Mon, Mar 10, 2025 at 10:14:23AM +0100:
> > for 83.5mHz, the integer divider generates 83.2mHz (-0.36%), but the
> > next LUT value (82.5mHz) is 1.2% off which incorrectly rejects modes
> > requiring this frequency.
> 
> Is the unit here MHz or mHz? I suspect the former?

Err, yes MHz; I was still half asleep when I added that example to the
commit message..

> Without having looked in detail, I think it would be nice to reduce code
> duplication between phy_clk_round_rate() and phy_clk_set_rate(). The
> former has
> 
> 	if (rate > 297000000 || rate < 22250000)
> 		return -EINVAL;
> 
> which seems to be lacking from the latter so I suspect there are more
> differences between the two functions than fixed here?

For this particular rate check, I believe that if phy_clk_round_rate()
rejected the frequency then phy_clk_set_rate() cannot be called at all
with the said value (at least on this particular setup going through the
imx8mp-hdmi-tx bridge validating frequencies first before allowing
modes), not that it'd hurt to recheck.


In general though I agree these are doing pretty much the same thing,
with clk_round_rate() throwing away the pms values and there's more
duplication than ideal...
Unfortunately the code that computes registers for the integer divider
does it in a global variable so just computing everything in
round_rate() would forget what last setting was actually applied and
break e.g. resume, but yes that's just refactoring that should be done.

While we're here I also have no idea what recalc_rate() is supposed to
do but that 'return 74250000;' is definitely odd, and I'm sure there are
other improvements that could be made at the edges.


That's quite rude of me given I just sent the patch, but we probably
won't have time to rework this until mid-april after some urgent work
ends (this has actually been waiting for testing for 3 months
already...)
If this doesn't bother anyone else we can wait for a v2 then, but
otherwise it might be worth considering getting as is until refactoring
happens (and I pinky promise I'll find time before this summer -- I can
send a v2 with commit message fixed up as Frieder suggested if this is
acceptable to you)



Thanks for the quick feedback either way, and sorry for the long delay.
-- 
Dominique



