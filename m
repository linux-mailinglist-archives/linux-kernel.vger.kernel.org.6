Return-Path: <linux-kernel+bounces-375701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C625F9A99A6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D928B281849
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 06:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A5413A416;
	Tue, 22 Oct 2024 06:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOKyS/hA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AB3433B0;
	Tue, 22 Oct 2024 06:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729577810; cv=none; b=uKZv4DXp1Nz4RWkSjlkTg8yBbRJ2WQ+KX/8gZ+6XIlMgxZfXtOQ7sBFmxAqFvIBKoOy7qmf0BGtAW/bmhFXzkwxx1R/VutTNzmnac8yku2RG7bfUalwSv/kETjgVYZp0isuTyVhipdkk8EFBEkTQYdeDSZx9Azmts426ZiUQYTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729577810; c=relaxed/simple;
	bh=dsiYHfMENw54Rwxddnc6oq2Qf3UAW+DE+wpic+MnsGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEc2LLVeM5ZEkKSyO1yKU5Im7zCrMzEpBfl4kLYFy2g5Wsplxvj1OwJL3/rGFwf4pW70XSWs5lIVUGBE1yNxt462u1Us7VUjLXSXpIx6tCmEt+DovEAhFI+cOl13nI0qTNAl278PtTvrrEd+6GkFG1+Rn+do8TaJBxOU5ebnioQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOKyS/hA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006DCC4CEC3;
	Tue, 22 Oct 2024 06:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729577809;
	bh=dsiYHfMENw54Rwxddnc6oq2Qf3UAW+DE+wpic+MnsGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tOKyS/hAG+QH3+pNntd7RV6hRZMfJYatkZDr5iXfIv1IijPTed0k0j41/2e3qEh9D
	 wSwTj48nYXxDI8jKiZQHtyLc0i3MBbOvaIIhGKHgXzEUQ8viaNAa0DDgXSLFnlx419
	 pMD7tkHDTr/uSR1crFGMVqSDIEkhMYPngtz4k4JNOMnXqDe3YzNMhDCh3DsNdVcegW
	 K5K3xi/utAiazNXKBnKeuS+Vr2T8n5j2Xp/XhMFZDAjZFmgL2ix288uitgs0ueprjo
	 mllBEdfOO+3hgpjHhzkY96jq7WubZjex82sVRxB2t5aDzF1Rf0+k2yrrnZaw7SqtNi
	 zwlkpNAbxBMNw==
Date: Tue, 22 Oct 2024 08:16:46 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Trilok Soni <quic_tsoni@quicinc.com>, 
	"Satya Durga Srinivasu Prabhala --cc=linux-arm-msm @ vger . kernel . org" <quic_satyap@quicinc.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: clock: qcom-rpmhcc: Add RPMHCC bindings
 for SM8750
Message-ID: <l7bs5xhoddlwggdd2ufc5lc2d33zkm2ewguwnd4t3gste2gjak@4qmcvkututzm>
References: <20241021230359.2632414-1-quic_molvera@quicinc.com>
 <20241021230359.2632414-2-quic_molvera@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241021230359.2632414-2-quic_molvera@quicinc.com>

On Mon, Oct 21, 2024 at 04:03:53PM -0700, Melody Olvera wrote:
> From: Taniya Das <quic_tdas@quicinc.com>
> 
> Add bindings and update documentation for clock rpmh driver on SM8750
> SoCs.
> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---

A nit, subject: drop second/last, redundant "bindings for". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

This applies to all your patches.

There is already CXO clock, so why pad is needed? All of these clocks
come via some pad, right? Commit msg could explain here this. Otherwise
it just duplicates the diff.

Best regards,
Krzysztof


