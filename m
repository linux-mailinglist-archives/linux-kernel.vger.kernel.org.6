Return-Path: <linux-kernel+bounces-534186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56183A463EE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067FB18939A6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2A022256D;
	Wed, 26 Feb 2025 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pf82xsg3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ACC2222D5;
	Wed, 26 Feb 2025 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581995; cv=none; b=ZbNJSfuBzMBPx/YIW9zQuWkbA6l57zIWQ2Ph8EoZMrhx/ALLG7DddKEwUTH2hJ0+UHZrmlE4DqxrdW5GrRPoZRhPD/bDUIhnew7+u36gSYVtBWtcbmbUIfbll4f8SkbuPBxZG0eD0PGTFgB07K420pY24ozYYWTJ7oAa5A01u20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581995; c=relaxed/simple;
	bh=5OsdiBDxPu2iv1r0X9avBecbm1x9d/4DtgPaMujJESg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMbe+9thnJPxXxizCoYo5SF4srfJK+jSRM05JUCqf7CCanj7EirjTc9ooM3VK5++/aA2Pgm++/75BworOCTGOuAN+KFO8epcmDOvZURpdY2uAc0JZ68FFKqBBXvnNw3flsx6UUuLoVbwp1Yiwq3biuckEL1BSG6x0S1JxexBC34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pf82xsg3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E8AC4CED6;
	Wed, 26 Feb 2025 14:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740581995;
	bh=5OsdiBDxPu2iv1r0X9avBecbm1x9d/4DtgPaMujJESg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pf82xsg3k9jh8QtGaWy1eQhTi9IN3uysZTF363aSirodmtrEFH37HTQrBGfud7KOy
	 xqX82R/DyaRbsNK/JrD4zRJsehcO4Jr5KnUI8wjr5wMS4s/sVmZu9ylppoETZ9yC7g
	 87OQBKgk6AFeQ34A2UAAXRA1jVd+Cco5qkXQcK3OJ59waQsDK1X9zLZkkiCBsFAgCP
	 cLAmYpv2RQIpQt7xmOb7rBHpWs68gdyK2V983VU2YsY/I5fiXoa1ugF54UkGeUuKOG
	 Rn9ZoT3aZGSaO5kFbRxKo5PYJ/aNWwqwNN1om6ZW11Xxk+cIJetbgNZgS20cbcQdfO
	 t7Ypmvo/hOPyg==
Date: Wed, 26 Feb 2025 08:59:53 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: "moderated list:I3C SUBSYSTEM" <linux-i3c@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	linux-kernel@vger.kernel.org, monstr@monstr.eu,
	michal.simek@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, git@xilinx.com
Subject: Re: [PATCH] dt-bindings: i3c: dw: Add power-domains
Message-ID: <174058199256.2331808.4044534396247326953.robh@kernel.org>
References: <fb8adcd318b1023ca6b90d294e46ae3b59dc1280.1740490666.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb8adcd318b1023ca6b90d294e46ae3b59dc1280.1740490666.git.michal.simek@amd.com>


On Tue, 25 Feb 2025 14:37:48 +0100, Michal Simek wrote:
> Describe optional power-domains property.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


