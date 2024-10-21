Return-Path: <linux-kernel+bounces-373836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A789A5D79
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E782813AD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93641E0DFE;
	Mon, 21 Oct 2024 07:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akYNUwnm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35BB1D0967;
	Mon, 21 Oct 2024 07:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729496897; cv=none; b=h5xxqzbtPOGbikqRJ11s6z+7+iucvTvW48Y/gj2OOl5Gk69+be0UuBPH78689EKoGQsyqkD1J/+K3tbX9/VJPjV14aV7GkB5egU8NPaYPI/nlUtLGz583NcCOBzjWecigzXQQebx6981QgXs6mc02vYpO91EV2U5+hwYtdMEEko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729496897; c=relaxed/simple;
	bh=kj2vhZ+kMQMEy+nK5Y60eJgzeck/WVVR+pcYR4qW7ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlQZaD6f5CtW1EUQUtQ0WHJOqcZ+MFZz+xOc2zduzp9CAQ4QTxOQ+tDJ+w7LkMBJB01QEml52c/JURS93zn6S6tyvf4a944pCw89dhGjS5VZHSKnF/B/CAbjluHC19frljnNBXQSce9SuVGuXNjCPGeSB5ogAt4k9WwaDQP5OkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akYNUwnm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B540C4CEC3;
	Mon, 21 Oct 2024 07:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729496896;
	bh=kj2vhZ+kMQMEy+nK5Y60eJgzeck/WVVR+pcYR4qW7ng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=akYNUwnmYj5Sm47P93hJ+imO+KZ5FL7a4XKWm8uUOUZiEPD2NFDuIH23SCI9x6146
	 EgLS006GQqku4QQNQKDNP3qk07ms4nfCCCq49+zBVfyQKI3asM3zTgMGEOewOC1E36
	 5qW18OcXsWwXFL0ORpboWJXvIX1xzTY9wG07HHRGJ52kGRovYtX9gV0ltnKEf/jj+C
	 G650paF24LaDhxO8Xeqy4skzGJ6tOe/pqltj5fLspRlF+a5QG15E5CLteUuJ4qsgGv
	 eymhBCHjtqPhTHZ1aUr/IzmM1utI4zqzzgdRSdnIE1KWGMVgr/hQk1YuT24U5/aT2y
	 dsQKPJnSfCfYA==
Date: Mon, 21 Oct 2024 09:48:13 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dinguyen@kernel.org, marex@denx.de, s.trumtrar@pengutronix.de, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 20/23] dt-bindings: altera: add Mercury AA1 combinations
Message-ID: <7b2prirjui4dp2ipopmndaygtqy3wv2bfetgvgrnyll4hsl6cv@c75b5edptn4a>
References: <20241020194028.2272371-1-l.rubusch@gmail.com>
 <20241020194028.2272371-21-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241020194028.2272371-21-l.rubusch@gmail.com>

On Sun, Oct 20, 2024 at 07:40:25PM +0000, Lothar Rubusch wrote:
> Update binding with combined .dts for the Mercury+ PE1, PE3 and ST1
> carrier boards with the Mercury+ AA1 SoM.

Say something about the hardware in commit msg. This applies to other
board bindings as well.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


