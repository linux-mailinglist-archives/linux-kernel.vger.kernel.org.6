Return-Path: <linux-kernel+bounces-299939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3E295DC92
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 09:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E675E1C21577
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 07:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6ED1547DB;
	Sat, 24 Aug 2024 07:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEozrN+s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFD12A8D0;
	Sat, 24 Aug 2024 07:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724485297; cv=none; b=Nn+sqy9uzTDhMPl+qyeSMpHbWgrP1bjIVQycekIOuaseOAO7Gz8PzQq0CAw7TiR15OMkQOLMFdvNfbDlMztYYSmey7Jw1hwr2MTEpdE/OPGyBRH3oq5bCfZCjgPET05ra/DKWYypKhpZI0MDWwGx8P6FrFB8dcTSPlknee4Rk1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724485297; c=relaxed/simple;
	bh=JNtDTLRPWbUWlktgWt2RLotoG9epS3wgRIvQl9U403I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCmuQ9cSobGmNKAJElrkk7zCBkB0CRLeO41r+R9OGpe3wwVjAQX5CyzEPtwXIt+N/R/CJQyE88pFWGjGGkfq29gLd2KMHSjQdqqpwwuWZAdOKtwo6o1/Kn4hE67JBoLpuojWYZjdOqAf63at/AtcMxGibeELX11SMiF+3qQYyvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEozrN+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7108CC32781;
	Sat, 24 Aug 2024 07:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724485297;
	bh=JNtDTLRPWbUWlktgWt2RLotoG9epS3wgRIvQl9U403I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GEozrN+swKfbQd9V13KWDTt1jTqIoCqg0zxQ3AY8mZWxo/bjGSmxuim+IZ3QfJwHA
	 U1Y4vQragJs/Y9FsuHbfn9jkHee/EdxMT31o/STSaUmeJsolOzqAN1kg4wUZPukuOn
	 o9Mq32vfJEqNB9cGUBE5JwzNHbwXQX0gZJ7LDVsBvSRvKbsszepWIaAaxXT2boXIlE
	 p80XtExauloCp5Rurs1rVQWT5Yqsi4mAhByZ59kIuG9pSnqNUY+lYkMsB9F+fIsIhS
	 BGKDkCdJmBB4nNQzZldyTTUlbG1Uf7GKTwYQ3PpZQPJhifP52YlW07o2ZmZJBanp5b
	 YmPCuzRkoPs0A==
Date: Sat, 24 Aug 2024 09:41:28 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Robert Nelson <robertcnelson@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
	Jared McArthur <j-mcarthur@ti.com>, Jason Kridner <jkridner@beagleboard.org>, 
	Deepak Khatri <lorforlinux@beagleboard.org>, Drew Fustini <drew@beagleboard.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: ti: Add BeagleY-AI
Message-ID: <jtsazkcsnxtzuvb3tkqwjpiitv45bbzuoxzvtqlso3ftedjans@ahqewuj2z7ak>
References: <20240822170440.265055-1-robertcnelson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240822170440.265055-1-robertcnelson@gmail.com>

On Thu, Aug 22, 2024 at 12:04:39PM -0500, Robert Nelson wrote:
> This board is based on ti,j722s family using the am67a variation.
> 
> https://beagley-ai.org/
> https://openbeagle.org/beagley-ai/beagley-ai
> 
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


