Return-Path: <linux-kernel+bounces-183859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BC58C9F06
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 16:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B154C1C21578
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990511369B7;
	Mon, 20 May 2024 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNxxzmK3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FD31E878;
	Mon, 20 May 2024 14:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716216679; cv=none; b=T4pdJqyphoQQlDwOaHITgUwZM/6CKmDLQ6S0R84+DAp2p2yd47Mxm1mcsvXIkp+w42quRmYaORzn8KZoamJS42txGprEbf7hDTuB9LDy62rxE6XTiHXQR9d+GaSEpkB9uQx6EXxJbGCGjcEaqLHOAUa0WiXHoNzkedQgj5ycwPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716216679; c=relaxed/simple;
	bh=D+Kqca1KEXxg0yNf3o5Zf6/5aAbEqPhGV7VQ7pMihjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1lO/qW3xLsw5jjSFKTA8gnyP2KG6n3N5m6ZgqmIS/OosHaO68jvQtn3xB7bwjLk3toec5NQdUNmK3HSn2hOdMyBAs7em2fqB5P0ag34UgqvqeSNm8Tusp22Dxej1bDNUmlAvhPk6piF+YTXFKJp/Kt1tqzWEsryBdHDfb6WA8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNxxzmK3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3101AC32786;
	Mon, 20 May 2024 14:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716216678;
	bh=D+Kqca1KEXxg0yNf3o5Zf6/5aAbEqPhGV7VQ7pMihjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oNxxzmK3tj6QsLYknhOkxRgQnSLppWoidfLzPYyT/ueo2FaiBWGuEMGQYK5lOEmtn
	 p3BYIZQn8HwaInlnHOGvoHxnTXWYYPmlJjS9InuTgjtEMtESTyjpDLdJWH4ED7+TF9
	 WuLkIJOdiWtijrI3PCgkV+6nf2VFkj0nbAYnl5UXcALoFyC2hVBSR7bbP20jLHmNg6
	 /i96MXLEjH9xMRLs7zJ57kmU/ymWZ+mEna4llLIsrO4XK9PfdeDMpsZmPZR/mKeJix
	 ZJml7gKQlmAzsXiAYJke+eTDpiVbGizLt2k3+foOaPLyai6Z1hhE8KAlSp1mWr3SH0
	 tlKVnZaXSEnhg==
Date: Mon, 20 May 2024 09:51:17 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, devicetree@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>, linux-arm-kernel@lists.infradead.org,
	Cristian Marussi <cristian.marussi@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: firmware: arm,scmi: Support
 notification completion channel
Message-ID: <171621667459.535282.3262936480019838224.robh@kernel.org>
References: <20240510-scmi-notify-v2-0-e994cf14ef86@nxp.com>
 <20240510-scmi-notify-v2-1-e994cf14ef86@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510-scmi-notify-v2-1-e994cf14ef86@nxp.com>


On Fri, 10 May 2024 11:19:47 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Per System Control Management Interface specification:
> " Completion interrupts:This transport supports polling or interrupt driven
>   modes of communication. In interrupt mode, when the callee completes
>   processing a message, it raises an interrupt to the caller. Hardware
>   support for completion interrupts is optional."
> So add an optional mailbox channel for notification completion interrupts.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


