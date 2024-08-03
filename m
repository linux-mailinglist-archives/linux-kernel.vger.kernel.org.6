Return-Path: <linux-kernel+bounces-273404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACD79468D8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 11:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA707B21660
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 09:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF37314E2E1;
	Sat,  3 Aug 2024 09:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfRUWyei"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0F2193;
	Sat,  3 Aug 2024 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722677623; cv=none; b=bBnJPZnOHubGhVA/DKTCwuCiM2Jsa/fq/TzZEjgv+HtsFf305bYYyKNJIoCYnkisn6JlA66vcZEa5Ro+7DBVQMmmffn0ifYE22M0AxklAUIvnlmq8xhaYA6E9CfeeZoyyoxqA9NxlA9xLj/0AWNXxa+/pTNAPcZc2j+Aa2sZctk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722677623; c=relaxed/simple;
	bh=TKsaHQVPb00GhJMF8L1NsNGCd0iON6AD7fG9oYP3HD0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ij9NSXWtXuniP2ziFn1MDUu4Ub8ox0rAsMHH5u05G+7PQZpiJYzkrLR5lDZZS4u6X6mTUZLflXnOhqvs/y9K1xan5nB1WreeJgwBRM0oxpd0WPlOKM5giH67oI1cdgZi71Zsn+22iZ521yeU5dQyryY41jSvl4cV3KKNkcexZbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfRUWyei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39921C116B1;
	Sat,  3 Aug 2024 09:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722677622;
	bh=TKsaHQVPb00GhJMF8L1NsNGCd0iON6AD7fG9oYP3HD0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JfRUWyeiZJijH6tKxMYYuKzQQ2Xr7euep81rXx03riAH85lsPLetRNEjvEXRdel0Z
	 6HzdqczRCeIGHrT8swF/LJnMRvEH+53NKsyYqLoFKP3Tvv2/ieGbqLbaSHedPPfwEE
	 jvxZcWp7onIGsY7SPUv5HXcnAkjhv21xbqO3LG8bJrZJ3Qef5nIgob9A8A/DBhALyu
	 2naXf6QQUGE3x0zqBFn3sN7b50WK1Lah2/PD3laAEPK4M9rhagzRXfoGdBnOfyfLcP
	 tOS9bc4wQ6+I3LPauP9iY3s31hR2G+ah74O/yT23ZsZIE3ag5KIn20WcQIKUW9cim1
	 pJiG91X3h3Mrg==
Date: Sat, 3 Aug 2024 10:33:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>, Sebastian
 Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v3] dt-bindings: incomplete-devices: document devices
 without bindings
Message-ID: <20240803103334.3f74ce52@jic23-huawei>
In-Reply-To: <20240712121146.90942-1-krzysztof.kozlowski@linaro.org>
References: <20240712121146.90942-1-krzysztof.kozlowski@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jul 2024 14:11:46 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> There are devices in the wild with non-updatable firmware coming with
> ACPI tables with rejected compatibles, e.g. "ltr,ltrf216a".  Linux
> kernel still supports this device via ACPI PRP0001, however the
> compatible was never accepted to bindings.
> 
> There are also several early PowerPC or SPARC platforms using
> compatibles for their OpenFirmware, but without in-tree DTS.  Often the
> legacy compatible is not correct in terms of current Devicetree
> specification, e.g. missing vendor prefix.
> 
> Finally there are also Linux-specific tools and test code with
> compatibles.
> 
> Add a schema covering above cases purely to satisfy the DT schema and
> scripts/checkpatch.pl checks for undocumented compatibles.  For
> ltr,ltrf216a this also documents the consensus: compatible is allowed
> only via ACPI PRP0001, but not bindings.
> 
> Link: https://lore.kernel.org/all/20240705095047.90558-1-marex@denx.de/
> Link: https://lore.kernel.org/lkml/20220731173446.7400bfa8@jic23-huawei/T/#me55be502302d70424a85368c2645c89f860b7b40
> Cc: Marek Vasut <marex@denx.de>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Nice solution. Thanks Krzysztof.


