Return-Path: <linux-kernel+bounces-447143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B79E59F2DE0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD8E97A0F6A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53676202F71;
	Mon, 16 Dec 2024 10:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZY/m9kjb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42E2433B1;
	Mon, 16 Dec 2024 10:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734343832; cv=none; b=qYNzF2CupAWsIUG5xC1dCK3pXgoL72Aih2yfiGtGQ7ObOjBcH2AzKFO6FaW2WxehKuMGfKV6DENCp3ay9B+ybhUJAdBa5epb6GDfoj4a4Uqom/2xNBbTDwde7b0tVciwtQ5MpryPub8+sBV2StAIDtovM4+m72lUIiT/QMldkjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734343832; c=relaxed/simple;
	bh=DHo3US+barN/B1pApHW1hS3kgGBz3ApiROFTgW1kzu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hy3LG6FrWBhVkQHLxOTn74U+hCHyUTEbJ8STIOLwNsH2c6oR1w6i7jzibVVY93gj5V6VDLnIoh4vPv4SRRvkUXjyPemWc5ShR8doOEPMX2CeU8oTr6SltEyOZA0YNznGvDtcA2N7ZAUQJRfGraj06yE29x3cNCTvULAIspur4So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZY/m9kjb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F89FC4CEE4;
	Mon, 16 Dec 2024 10:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734343832;
	bh=DHo3US+barN/B1pApHW1hS3kgGBz3ApiROFTgW1kzu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZY/m9kjbVdoQz2EgEBlIl65+yestsZYUnYPJui3XVZ5ERgQB/dwDKvKWpTKgqExQE
	 qqPRGnYB0IsEXjD6uYydGWv3hato0cQA6I9u4JL/T8XO1mDRFXL5uIlh2efii2tm/R
	 RjI3mRG9VViFjtrzjwot/kkp7SGLaN9htm7CvWzR++WElp+0GUT+mhua1mvObXuhjH
	 5V17OADdjvz0S9fh44B0yeMnGP5vZZLAy+DZWJL/0I5AlePsWLf9CB4stg2c2+2N0M
	 3ciXTvGTkd9iNeKu2SCJFKN+30EgFtuRPAi+Bo8D+hgvdeZRU4XWHuD3DjIgR3VtD5
	 HhE/VGAUNSGqA==
Date: Mon, 16 Dec 2024 11:10:28 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Animesh Agarwal <animeshagarwal28@gmail.com>, linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: realtek,rt5645: Fix CPVDD voltage
 comment
Message-ID: <pqcxjnvbgdycckztccrzf7mgr2gslwt4kvumdpoovq4phdss53@z6r535fmbcxt>
References: <20241211035403.4157760-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211035403.4157760-1-wenst@chromium.org>

On Wed, Dec 11, 2024 at 11:54:02AM +0800, Chen-Yu Tsai wrote:
> Both the ALC5645 and ALC5650 datasheets specify a recommended voltage of
> 1.8V for CPVDD, not 3.5V.
> 
> Fix the comment.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


