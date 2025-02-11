Return-Path: <linux-kernel+bounces-510059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7512A317B7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 227D61888298
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 21:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEE626658E;
	Tue, 11 Feb 2025 21:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5o8gSPf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94463266598;
	Tue, 11 Feb 2025 21:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739309370; cv=none; b=q7tnp+UENJE+u2NoLuAhyMh+XFlDP5yqoMVhG91FQaZy9vwkvrP8BDZjEPC/h6iDEb3SHbock7bmhdnCCcU+4Uu38u0H8SP0M/S6IOnqWOLYrAO7J1Qw4qLPpjrU7U3IYkKFUaIwzlBKG6f14lBKRlEML78trW0CxeA1aPlzMgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739309370; c=relaxed/simple;
	bh=NaUS/xid8E3zDqwf+U421yyey7c36cXUSga07rj7yNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phAAejf5kI/wlQ3uqrGIF9Vyq2/iSwPuGrcJdIdxHbjQtqv1tL8vR4T0pTiU1TQSWmp2xJJrwyRO6xMcMfm8ZgA9ud02B1OtMdCSK4Ek75y2gesgZbdao8V28PGelr/pjfaa7/s0xMONjS9cJO+1SyZG/ZCpvNf3gWRbNDsh4Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5o8gSPf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA14BC4CEDD;
	Tue, 11 Feb 2025 21:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739309370;
	bh=NaUS/xid8E3zDqwf+U421yyey7c36cXUSga07rj7yNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k5o8gSPfQq4IgyVNNnH17NgMRkO8e4gyfCOrL/4gYWEoThBhBYQyKJ5EyvYgel9BD
	 eZziKOsCNPSFb5c6YPFys+0z1OyUjJzXIlJDNDgzLCViFLQX+qJCO4hhOLEJbdiEAl
	 svknN0H4vkcntQ+K3SdJAqFt+4kK7tdAa/06eexV98C1mLaqfvEcjQTZKLYCZct0Sk
	 fy8sFJK71nx5PS4aKFrVhxWIvVTPQE6FeMMioDRtIT0jAoDHJ2JG+snexxBQkVDU+o
	 AiowVHT7aemYqByHqTwCPBozswKNo0Wpjf2rAWfO4RobedKU/ihnaCr9GUYWlne8V7
	 w2S/dWjbgKOIg==
Date: Tue, 11 Feb 2025 15:29:28 -0600
From: Rob Herring <robh@kernel.org>
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@amd.com, amitrkcian2002@gmail.com
Subject: Re: [PATCH v12 1/3] dt-bindings: mtd: Describe MTD partitions
 concatenation
Message-ID: <20250211212928.GA1188800-robh@kernel.org>
References: <20250205133730.273985-1-amit.kumar-mahapatra@amd.com>
 <20250205133730.273985-2-amit.kumar-mahapatra@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205133730.273985-2-amit.kumar-mahapatra@amd.com>

On Wed, Feb 05, 2025 at 07:07:28PM +0530, Amit Kumar Mahapatra wrote:
> The AMD QSPI controller supports an advanced connection modes called
> Stacked mode which allow the controller to treat two different flashes
> as one storage.
> 
> In Stacked connection mode flashes share the same SPI bus, but different CS
> line, controller driver asserts the CS of the flash to which it needs to
> communicate. Stacked mode is a software abstraction rather than a
> controller feature or capability. At any given time, the controller
> communicates with one of the two connected flash devices, as determined by
> the requested address and data length. If an operation starts on one flash
> and ends on the other, the mtd layer needs to split it into two separate
> operations and adjust the data length accordingly. For more information on
> the modes please feel free to go through the controller flash interface
> below [1].
> 
> Introduce new DT property to specify which partitions are concatenated to
> each other.
> 
>     flash@0 {
>             reg = <0>;
>             partitions {
>                     compatible = "fixed-partitions";
>                     part-concat = <&flash0_part1>, <&flash1_part0>;
> 
>                     flash0_part0: part0@0 {
>                             label = "part0_0";
>                             reg = <0x0 0x800000>;
>                     };
> 
>                     flash0_part1: part1@800000 {
>                             label = "part0_1";
>                             reg = <0x800000 0x800000>;
>                     };
>             };
>     };
> 
>     flash@1 {
>             reg = <1>;
>             partitions {
>                     compatible = "fixed-partitions";
> 
>                     flash1_part0: part1@0 {
>                             label = "part1_0";
>                             reg = <0x0 0x800000>;
>                     };
> 
>                     flash1_part1: part1@800000 {
>                             label = "part1_1";
>                             reg = <0x800000 0x800000>;
>                     };
>             };
>     };
> 
> The partitions that gets created are
> part0_0
> part1_1
> part0_1-part1_0-concat

'part-concat' doesn't work if you have multiple sets of partitions you 
want to concatenate.

I think you need something like 'prev-partition' or 'next-partition' in 
the partition nodes to create a linked list of partitions. Hopefully, 
you don't need both properties, but you do have to scan everything to 
figure out which ones are concatenated or not. For example, no property 
can mean not concatenated or last partition if you use 'next-partition'. 

Rob

