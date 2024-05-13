Return-Path: <linux-kernel+bounces-177788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4349D8C44A3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00378288821
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FAC155324;
	Mon, 13 May 2024 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieDlxfXp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF841552E8;
	Mon, 13 May 2024 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715615611; cv=none; b=he2nn+pxgIsg4bCrCbTF2SoL5OR4/G57602Ju793+5GaIVCtl78vBlShj/FtQ17mv1Gkgl3b20vh9Voirn4Om7/rpYuRfTLpk6vY+YrWMgeslZDKt+7keSmqQf7baHpJciZVBiNbi3iLPq6SrBxLPVHvQoA5+AQayW5LlQqYOs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715615611; c=relaxed/simple;
	bh=QSJ9adYiyENvXrlQE+wO4TcEhBc9/Ph17/BE6YNfe6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYWGajgCxbPxmW33iGRvgKhWalmar3nvot3WPs/OM45BY4k8YppQKGarpBgTcVEtnugSxSub2lSZOea3XkfkJMIOPMtQNDnTiRjkGt/JDioJzhf1kPxOoXpKUR4RDWglJYqt1RDMHYHvMAK05SrsQq2aPU2JMv50RBFZGzGYjas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieDlxfXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25109C32782;
	Mon, 13 May 2024 15:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715615611;
	bh=QSJ9adYiyENvXrlQE+wO4TcEhBc9/Ph17/BE6YNfe6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ieDlxfXpA9mxINnKrBrM2GCwrkLA9HNJPKbLm9C/lqpQFq0LO17JxHQ5uZA+KL6rT
	 fJyNrr4u65gmS8FFm3lb5931uxXg2yS9xUTJoCWACUw6M/nAKyrIP8HaZmVGIvIaQ+
	 bfOQZ2bKhDtjDd5XX23odoR30gx6gTCdsLQ3ZWzdH1SSBSKBM/fR7wTnddJ42JOgC+
	 baHJi9lP2OF4w6InqIIQnayFq9bNTna2TackQajsyBnp0ql54m+U08BEocIAcTCzIX
	 3c9N+3FvSE8SxUcuaUm0v3ONTToHAGatMO9OikwYDDGZhIaDGKNSwVOP+ZUQs1UGik
	 E6oy83RDLePNg==
Date: Mon, 13 May 2024 10:53:30 -0500
From: Rob Herring <robh@kernel.org>
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, tali.perry1@gmail.com,
	joel@jms.id.au, venture@google.com, yuenn@google.com,
	benjaminfair@google.com, openbmc@lists.ozlabs.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v24 4/4] dt-binding: clock: remove nuvoton npcm845-clk
 bindings
Message-ID: <20240513155330.GA2676859-robh@kernel.org>
References: <20240509192411.2432066-1-tmaimon77@gmail.com>
 <20240509192411.2432066-5-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509192411.2432066-5-tmaimon77@gmail.com>

On Thu, May 09, 2024 at 10:24:11PM +0300, Tomer Maimon wrote:
> Remove nuvoton,npcm845-clk binding since the NPCM8xx clock driver
> using the auxiliary device framework and not the device tree framework.

Again, this is an ABI break. Changing driver architecture for 1 OS is 
not a reason to change DT.

Rob

