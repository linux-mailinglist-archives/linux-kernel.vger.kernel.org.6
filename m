Return-Path: <linux-kernel+bounces-319121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DCA96F7FB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208A128556E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64C51D27B8;
	Fri,  6 Sep 2024 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="wNmZzNvJ"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7351CBEA1;
	Fri,  6 Sep 2024 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725635717; cv=none; b=c47ZH4YiVdn/pdDbE9CW65z7o+65yCt4766KT0sew/bA4D3S9wnMFoKzlsgzWl+IF21kun2TC8pojUZPPjZmAYs9ZATtfivp/fTxOUAi2V1GOlvDYEEjvBk9xk6xrkvJCR8V4JJ68Qm9xX3XOzW/cstPi7I2E69C24syrjpYY+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725635717; c=relaxed/simple;
	bh=Gnc/4KAM4fHA4+upX3cvFTZXBC9ilSaBQYoGOG13GG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEr7u1DekoI+lw4Bjf4/IuGlFZyGbNONQ4BPhuYFzfMdB1YyutHS1Q/R12kzELybL7Cvqu5CN3yunvHFXxWaEhBPexd/fI0LPY74tSZhd2hxjbKCUDDvTg4gFVUfaLMZ2t66rEB1PHcViB9ha9DQtmuT8akBZ1dT15+rYfulO2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=wNmZzNvJ; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 9253F1F9DF;
	Fri,  6 Sep 2024 17:15:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1725635713;
	bh=CrABqqyh4+mS8jDbX2WPd72bPfeYdPw2R1LFZwEqFEQ=; h=From:To:Subject;
	b=wNmZzNvJTqvhw+SnezFKo2QMTd0PrUvBWX0w4wQcwLEYVx9hIfdys+o0yECJNdbay
	 HSWyGJjYq+8QEoKGCR4c2MFaZee5TwzPRGtzdgQ8leqPSr/HNkPrdQmw3L0teaEfch
	 ZmE8DDe04JzKv5xUQ46dWgukf+9OpaM0omdhasQDRP+INTuBNovAcyGssD+uTOshIM
	 k31+meUuO354iL8LCLWso6/+EW8uirxzXN/f/yrZHISti08SM5KSiJHBBxKH4b9mzB
	 6n3jpkyzEkv9ToVV7C3OWe6BsKDAstpeX97p3qFhONKqYsmnkZAuCw+QAzVNerQYkN
	 sYrLedEZkKmOw==
Date: Fri, 6 Sep 2024 17:15:12 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] wifi: mwifiex: fix indention
Message-ID: <20240906151512.GG45399@francesco-nb>
References: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de>
 <20240826-mwifiex-cleanup-1-v1-9-56e6f8e056ec@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826-mwifiex-cleanup-1-v1-9-56e6f8e056ec@pengutronix.de>

On Mon, Aug 26, 2024 at 01:01:30PM +0200, Sascha Hauer wrote:
> Align multiline if() under the opening brace.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


