Return-Path: <linux-kernel+bounces-307004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4539646AE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07A4284509
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AD01AE864;
	Thu, 29 Aug 2024 13:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LlrpPLFY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923291AE866;
	Thu, 29 Aug 2024 13:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938083; cv=none; b=ZYHeBRPFZ8wks2kQSd7jIGLnB+AOaRz59Ls+IypGFOMR2isuFkiJ0aqMCANnGglLsDA95dt8MTHRZkVJTxja7xPsFHokXkcv6nfbpb/69GZhtffcAFkD08Q4Mmh3ECbaaHlBMLhN5QLKoSi86JUCgfLMynvQWcdWeUZDZJAmU4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938083; c=relaxed/simple;
	bh=BCz8KQT3nNiku5vwtOuMR0szTCOE3r+CGyVRcDkjTcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZ3GXNNF99S5OYq28wBDJkP/lF64zo/HmrJw0lAGCP1osbAX50j/r22Bt2PL3Zaudg77AYPol/bTAKg9OKsA9PVkEa8EZEWoxd/LHA+SptDGmRPyMab+RFN7TJQM+/aEaMJJb2QsyxBYk70HJcBw06Pe/LTlwHj4rCqLMVyyr/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LlrpPLFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFEFC4CEC1;
	Thu, 29 Aug 2024 13:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724938082;
	bh=BCz8KQT3nNiku5vwtOuMR0szTCOE3r+CGyVRcDkjTcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LlrpPLFYXygagotx7+N3+XIHWOWL2VFPduet7kczz/2iJ9fThHKNWsTVHHAuNy7cV
	 KsMx6E0k8j89Oski9nKCEFc50wozYAaGfbSdoDeDqyTK9X/z1Nf/DVTm8H1M69L7D5
	 auX3BearRXImb8/wNcQhR7sBCjf3iBV37huQSWx0=
Date: Thu, 29 Aug 2024 09:28:01 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, 
	abelvesa@kernel.org, peng.fan@nxp.com, Wei Fang <wei.fang@nxp.com>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v3 0/4] add NETCMIX block control support on i.MX95
Message-ID: <20240829-ambrosial-smart-wombat-fb571e@lemur>
References: <20240829011849.364987-1-wei.fang@nxp.com>
 <172491778768.2521946.17064463983702008243.b4-ty@linaro.org>
 <ZtAo+B0XOE558+93@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZtAo+B0XOE558+93@linaro.org>

On Thu, Aug 29, 2024 at 10:53:28AM GMT, Abel Vesa wrote:
> > [1/4] dt-bindings: clock: add i.MX95 NETCMIX block control
> >       commit: 4b78b54762dbfc2f22f28655fa3cf6f5d50de197
> > [2/4] dt-bindings: clock: add RMII clock selection
> >       commit: b4f62001ccd3fa953769ccbd313c9a7a4f5f8f3d
> > [3/4] clk: imx95: enable the clock of NETCMIX block control
> >       commit: 42dc425fa8b5be982bcc2025d5bf30be8b26da86
> > [4/4] arm64: dts: imx95: Add NETCMIX block control support
> >       (no commit info)
> 
> For some reason, b4 ty thinks it's OK to mention this 4th patch as
> applied, while it is obviously not.
> 
> I only applied the first 3 patches.

Sorry for the confusion.

It's because you did "b4 am" on the entire series. We couldn't find the
matching commit for 4/4, but this often happens because maintainers tweak the
title or the patch contents, so we can't always assume that the patch wasn't
applied just because we can't find the exact match.

If you know you're going to apply a subset, it's best to run "b4 am -P 1-3" so
that b4 knows for a fact that you only intended to apply a subset.

-K

