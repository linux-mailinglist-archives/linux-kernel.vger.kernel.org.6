Return-Path: <linux-kernel+bounces-248246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED8E92DA8F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48E04282124
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F27D131E4B;
	Wed, 10 Jul 2024 21:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="io4U0kE8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AB3502A9;
	Wed, 10 Jul 2024 21:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720645758; cv=none; b=gwcjQ/M6EKSgFq090hziRRInGpk+cnoBxUdQOu4oaNbTMf5yg7h6kJGfak1Y/+V6retUcPuh06pLkHIe0X75jaq3xU0xHcRQBytYYrrn9JbjYMDDwqAjZoeIXVyGhhx0X+gSnLQp07AJzL9oCZXuRIeJeHDwqISZpclrYLvJLaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720645758; c=relaxed/simple;
	bh=grYbuyfrj6pNtJ40Wij1nPQouqoiFgrUmzpUAfnDEMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fc2s+onIiFqZGcCnY3JKKEx2AP122PsZt3i6b0xu0h+tvyD/f79CdvhcSi2Y09KVQVpGkKHEQu25IPDWApfDsp6QggsrVriYim9EJPVmBeHEyHCYp0XMyM1bH98OTOAWUQVlCdEqguz8pz8d09I7H6CC7MP6zE3bSwy73hv8K/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=io4U0kE8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F28C32781;
	Wed, 10 Jul 2024 21:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720645758;
	bh=grYbuyfrj6pNtJ40Wij1nPQouqoiFgrUmzpUAfnDEMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=io4U0kE8LMsx3Ub0aJACKNqUq7b+5koJkuX1PN5iqZ8unxhk6fhzMtler8jLwNKKN
	 Ci9jRy4mNK+yZ2FTO2Siex8GLkGTdRGJLPs4BIRpjmBu+Qdp8uUpsqMf/clp3wXZcl
	 frmSMQGLg3B5ScMk5TlUuymG7NOJPtbr7rhZrhPurSoJ6bbnLg3QsEGGI5w8iRP/tn
	 j3Md35OosQeWnBfsoqdLh3TkEQxLg8MvEgoSIKo3gemvf64IUanlFx1MUzDTn8vfrh
	 TJMcWAt4AyYKl8FLQ+6Irjo3u5hN+M6x4836TjO+vS0qsuBLQfO4hK0ZVjTCmMOypW
	 GhVcwJhcZQJcw==
Date: Wed, 10 Jul 2024 15:09:16 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, will@kernel.org,
	jialong.yang@shingroup.cn, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v2 1/3] dt-bindings/perf: Add Arm NI-700 PMU
Message-ID: <172064575490.3730136.6789600718174419899.robh@kernel.org>
References: <cover.1720625639.git.robin.murphy@arm.com>
 <e60059b1f4683bd1863f08dd03482e5948c0afb1.1720625639.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e60059b1f4683bd1863f08dd03482e5948c0afb1.1720625639.git.robin.murphy@arm.com>


On Wed, 10 Jul 2024 17:09:33 +0100, Robin Murphy wrote:
> Add an initial binding for the Arm NI-700 interconnect PMU. As with the
> Arm CMN family, there are already future NI products on the roadmap, so
> the overall binding is named generically just in case any
> non-discoverable incompatibility between generations crops up.
> 
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v2: No change
> 
>  .../devicetree/bindings/perf/arm,ni.yaml      | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/arm,ni.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


