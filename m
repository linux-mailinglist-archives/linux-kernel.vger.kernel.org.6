Return-Path: <linux-kernel+bounces-428493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6979E0F47
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 00:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2E66B21A7C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 23:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227EB1DF278;
	Mon,  2 Dec 2024 23:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WL34uAMA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ECF1D79B4
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 23:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733182055; cv=none; b=Oyjny6PHS55wW2n/R35v3j1NG8G9zj8Ei5DgGw6yxQx/jtHkEI20WC0fvJHlvPWvuQW/wvfTZJSGGsJ8BtiRJyYRH7/FbiQzWLSKInHLL/wPDMesfvcHELHgkjXp9LDLUdQCEFYl06XMbwQuMrzVG+TT5K7RJEL3rr94db7WcW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733182055; c=relaxed/simple;
	bh=E22bR8bDe5QTkFnCEckdTV4+oRfPtKxdqEpslyVWPl8=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=XWhuesC1WXyYAjjAwMFY77fXiP23pnAINvcrxTQGQ72EpuBeJkip2xTwH2FPKxZAKCITSHy1buYKs88AyDioHzDMdWE3BdPdy8q2bT/tZMWi5qkzlBNM6QViFYJQrO1X1bhQ9i4ZESTW+zelqQzZpVDl5pSsvQxneYOxLA4MQj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WL34uAMA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C627C4CED1;
	Mon,  2 Dec 2024 23:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733182055;
	bh=E22bR8bDe5QTkFnCEckdTV4+oRfPtKxdqEpslyVWPl8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=WL34uAMACdpiB7YX/yFdTN67dPwPzhikUNu0ckz8AnI2GAtj/5Ao69S0mA3kpLZDk
	 c8P/fGSlBsA0w4t1K36XeYnLq5UrEVVhtj2i/22HnvTvBk762zDJnP5TFaU4Rsbmr0
	 W7VUjZDkfO5Ks/121qa6H7M9EC4Z2U7iSz20ypdlhLWBDpVAm4fsOHcumNi9w4Tl6V
	 6Ez0m3kWDKE2g5NEiZGTxWDEDLjnm7XNOfbDrzy2RIOwxbVSG3FlVZwr+PsOQE1RoG
	 TiPf2ZiD2tZkBaivBMIL2zWZe8MO1ste/RNZMO5kmdKJR4DmzHNVq7S572sXLdlHJk
	 n5i+lIWT9r2gQ==
Message-ID: <2382757db0ec7485700463b9ac7fcb11.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAGETcx8B+MZm_ZOFkK=KUvV_9q+48Zvkw8C-oenvvAKX+0+e6Q@mail.gmail.com>
References: <20241115230509.1793191-1-saravanak@google.com> <CAGETcx8B+MZm_ZOFkK=KUvV_9q+48Zvkw8C-oenvvAKX+0+e6Q@mail.gmail.com>
Subject: Re: [PATCH v1] spmi: Set fwnode for spmi devices
From: Stephen Boyd <sboyd@kernel.org>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org
To: Saravana Kannan <saravanak@google.com>
Date: Mon, 02 Dec 2024 15:27:33 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Saravana Kannan (2024-11-27 20:23:01)
> On Fri, Nov 15, 2024 at 3:05=E2=80=AFPM Saravana Kannan <saravanak@google=
.com> wrote:
> >
> > This allows fw_devlink to do proper dependency tracking for SPMI
> > devices. So, better deferred probe handling, async probing, async
> > suspend/resume, etc.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>=20
> Stephen,
>=20
> Gentle nudge. Plan to take this in for 6.13?
>=20

It doesn't look like a fix and it was sent too late for 6.13 so I was
going to send it over for the next cycle.

