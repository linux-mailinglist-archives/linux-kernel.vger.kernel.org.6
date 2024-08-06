Return-Path: <linux-kernel+bounces-276593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 210D89495CC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522AD1C21628
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA1A40C03;
	Tue,  6 Aug 2024 16:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXoLxWwT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D130440855;
	Tue,  6 Aug 2024 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722962600; cv=none; b=CUYspEfK0lBAqlYwLzK6Kc19k3gsZOoK0l/fGSmQrPhCIPHaXo9u0a3MyXvBiJ4zYzNlB4t6AoxdTJUoB4YiQujWFX6wBynFzUmLv2+zJVgaIbRnThtfToNcAyL9RJswv2tC/MvZ3x7Upv4F8n8nFDmt+CM8xxxVaxVDsJAZB8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722962600; c=relaxed/simple;
	bh=6sClNhUjZGc5IElVN986RClwKPdOaCq/0tCIgx/Da/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfTHsHTzjboYBDl6F879HbTQqJmQAMnNI1UyB/Y9MUSg+V963uk99ojRaAXUaJ+zHqn/PvhuYxuSvwRB0AjpojXdAE8lQ7JKSejKmWoItm9enIIxF82xckpAJH50GXrv/jUSYtsVMPbBlsyMsCmAr/J7xWxh5UdOVWLx6689jY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXoLxWwT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454AFC32786;
	Tue,  6 Aug 2024 16:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722962600;
	bh=6sClNhUjZGc5IElVN986RClwKPdOaCq/0tCIgx/Da/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FXoLxWwT32Kv/iYLfVxOWQGgRp6AhLciUOwtVgSueRuIyFa30wROGjck+YpxJitJI
	 T1OLiR5wpbpuiq3ixc9+WJ+0aisJvQLSQXSOfW0psESKKggjN35W29pFDyzGJSr4xP
	 6NuVePXTBbW8GtEjKEC9rmLhHcBnyNGpjf/bxxywv+lpEGJXaLIeiZD7AZyUx67PYs
	 Syj74eaUeCvEBOQzHTmeXAWG8wrPw9eo1QMeTI7fb/h+XB6ziSWd7uX+Mw+OG2MOEY
	 4xR/wKUiPdWpDAWlAi6WCf68DXb/xH9Vp/lXScakkkuzukm+Ps/9rv8PaBN9hsJ0AJ
	 IjnSksdOfXiNA==
Date: Tue, 6 Aug 2024 10:43:19 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: timer: nxp,lpc3220-timer: Convert to
 dtschema
Message-ID: <172296259811.1664225.7783260946713632584.robh@kernel.org>
References: <20240731074544.208411-1-animeshagarwal28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731074544.208411-1-animeshagarwal28@gmail.com>


On Wed, 31 Jul 2024 13:15:40 +0530, Animesh Agarwal wrote:
> Convert the NXP LPC3220 timer bindings to yaml format.
> Add missing resets property as it is already being used in dts.
> 
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> ---
>  .../bindings/timer/nxp,lpc3220-timer.txt      | 26 ---------
>  .../bindings/timer/nxp,lpc3220-timer.yaml     | 55 +++++++++++++++++++
>  2 files changed, 55 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/nxp,lpc3220-timer.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/nxp,lpc3220-timer.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


