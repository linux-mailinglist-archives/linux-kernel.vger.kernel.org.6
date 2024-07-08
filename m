Return-Path: <linux-kernel+bounces-244629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9664A92A71F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428121F21478
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020D6146016;
	Mon,  8 Jul 2024 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRh2TeNj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBA51459F1;
	Mon,  8 Jul 2024 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720455482; cv=none; b=dyANjaAibQVdpQ1N8tlQlmIOZApjqvx+Ultx0r6DFYWofu6Ied18jHlBmODWH0m4JJDlkB6wYmiS4gT8EkvQbROWa2vxgHnNjxV9COxFZ4YS/DUhy+qN7uyxBJ9QfzGLik5ZNy7YiErPvB1Y5lShgBcpqYrom4PEV66O7sxGT5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720455482; c=relaxed/simple;
	bh=QoaVgsZD8hy36oHKbzcku1hqiZ0FKuot0Efhu3zp1+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQjusuNd9IK96xyoPH7tb0swUtB0XmAUNyWVYv65cBexTMSfE3sj3tLiYSZTzPMdWEOiQ0oysVgcm2SMsy1Gz7CX9A/4d232ji4IHeL0WYTutYcQHZzFkEfmvNphxZg5Lil+RdpavfdDSAtf7BVoQFGgZ9rNdGlcZu0A7wmmz6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRh2TeNj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84310C116B1;
	Mon,  8 Jul 2024 16:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720455481;
	bh=QoaVgsZD8hy36oHKbzcku1hqiZ0FKuot0Efhu3zp1+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YRh2TeNjZr2EOLI59bZofrPETHvNYt49E+lp7HQCFNsGyN5P9nWocMv/CXnrpvznf
	 qoBYIYPn9mVH1Dms0kXDUWqFSG/+KzWIE9yE1y5OXQsSk5DsWiyoW3jBcEu2saAglP
	 T3GOwIsSkhWgRqRzTS/7SbjHfx7ncJ6o78yS/0Lstmp5hod0hYY0F3zgsULLf0iHy0
	 RfYq2zIHEf/4r+kLRzXKVH/g2vK0ARpswtbrEJ7p4pz2fDa2rJOySzd0br8NNQkxjZ
	 jSRNUPqG1i9jndyTBHFRpTZO6ryNe1SVRH4YuVbF3Juj3plaL4dgeJpiU+NOLhTeQQ
	 4s+tj5GYsz4mg==
Date: Mon, 8 Jul 2024 10:18:00 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: soc: fsl: Add fsl,ls1028a-reset for
 reset syscon node
Message-ID: <172045547768.3343964.18121524325838710438.robh@kernel.org>
References: <20240703-ls_reset_syscon-v1-0-338f41b3902d@nxp.com>
 <20240703-ls_reset_syscon-v1-1-338f41b3902d@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703-ls_reset_syscon-v1-1-338f41b3902d@nxp.com>


On Wed, 03 Jul 2024 14:08:11 -0400, Frank Li wrote:
> ls1028a has a reset module that includes reboot, reset control word, and
> service processor control.
> 
> Add platform specific compatible string to fix the below warning.
> 
> syscon@1e60000: compatible: 'anyOf' conditional failed, one must be fixed:
>         ['syscon'] is too short
>         'syscon' is not one of ['al,alpine-sysfabric-service', ...]
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/soc/fsl/fsl,ls1028a-reset.yaml        | 56 ++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 

Applied, thanks!


