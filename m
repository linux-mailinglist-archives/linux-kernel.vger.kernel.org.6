Return-Path: <linux-kernel+bounces-524618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C88F5A3E547
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1DE219C4634
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF363264601;
	Thu, 20 Feb 2025 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxElOzbA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107A82135BB;
	Thu, 20 Feb 2025 19:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080142; cv=none; b=uKohyrWjyvdi+o6jIr2HihKi234d27D3UKqcurkXordaPejjDPOntKGqITCkB4S2rLon4oJ2x73E1Wg6Lqzd2ds+JulI2U45BPNhvqSlbeT42nlark+YkhLSilJdoHGuUngmmwcHTSHna2YoUj7Xq/jZ1fVv4cZm2ZpWcjymGDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080142; c=relaxed/simple;
	bh=7kjqcZYH1aUFY25Xm511+6QLXPnGhjWBvnIDK8/poMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/mr/gWwOx5VTcpLPGHaMY6Ly77PlMHV5dmZ0BHvNQkuqgCn1t2/uP1E7QzuE6ys6uF/Ymj3kqgPCgpdfcB7aI9AvHwst3z7MPQ0EJY8pdXVJrW6ov9pDEzk9MBloKnDGQMhC3vuYp2oVfhcwYpK0cVNvarNOceHjnns+c4Z+Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxElOzbA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB54C4CED1;
	Thu, 20 Feb 2025 19:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740080141;
	bh=7kjqcZYH1aUFY25Xm511+6QLXPnGhjWBvnIDK8/poMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OxElOzbAwbFMCn/ifGiwuYqwVGzs8UPlrhp7VCd0exsYhGc5t0/1p8lCJgwsWWFUV
	 Qj8wRVyZlSLbT3JRTjuXwvmwW4wSXl6Xy3l6VvZOj/DeKOqF2kJRyB4o/Q59O8V24F
	 YoOvRHpnQJtlHDe5iCFUFAxaln9F/NrmgNV4oQyz5tb9WTsgVKVNtI7Ta13kfQpi2X
	 xSCQw5OayJu3noHjo1FwAezbLhrkqe2RTUKuR+1n21FA7Rjfsf2R7NSN7/5NtnCf+p
	 1WpvZef5h9+gIjCNd26uhDg4DI1iOm7ugOFMYK4FZgPwuzDrI1lp+juAQJ3M/P+RL7
	 +alOdDkGyx5eA==
Date: Thu, 20 Feb 2025 13:35:40 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: monstr@monstr.eu, michal.simek@xilinx.com,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	git@xilinx.com,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: trivial-devices: Add ti,tps546b24
Message-ID: <174008011483.3792136.4684256784697104381.robh@kernel.org>
References: <c79f69d0d37e7eb61f93f5dea69148b7756a3ee5.1740056021.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c79f69d0d37e7eb61f93f5dea69148b7756a3ee5.1740056021.git.michal.simek@amd.com>


On Thu, 20 Feb 2025 13:53:43 +0100, Michal Simek wrote:
> Describe TPS546B24 DC-DC converter which is very similar to tps546d24
> version. The difference is that B version handles up to 20A. D version up
> to 40A.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  Documentation/devicetree/bindings/trivial-devices.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!


