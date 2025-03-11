Return-Path: <linux-kernel+bounces-556659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBB6A5CD03
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42E767AC9F3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46302262801;
	Tue, 11 Mar 2025 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QU9hDdJb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51BE1C3C07;
	Tue, 11 Mar 2025 18:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741716072; cv=none; b=Lk8y+DG18C4qPytNfdG5wiIaIKnvpUGqv1i62xr7+DVdHzEzjewsdlUFXwkrD+v7Aur5dXbXmQ6u+8sdeM5i7Uia8Vpl0u9YDVayMxpgeRxPbrfW/9EEcCC5UvixDhZyQ5tMPDQ27g6ujStl+LBvoiVa4Zc1TSczj1cw6X2rV+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741716072; c=relaxed/simple;
	bh=XKJ8eHi4vIaadzkf88HCuZxu4ufJtTPavk8/qewEMSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXTquvU7q1QM3zMXgzn14QJwAkEDYdbWwTPHzclZWiq8T9hutZlEJPGq6PeyR+ifFnlpcl0qjpGQgd7V4gXP414wSv0hdsgxbA9yQ2BLaEKZe14MGOxYjmplP/mM1M3kn4sxPBgFihbmXbFD5xp/GkeNajakdpNvt99+bctmHyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QU9hDdJb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0077AC4CEE9;
	Tue, 11 Mar 2025 18:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741716072;
	bh=XKJ8eHi4vIaadzkf88HCuZxu4ufJtTPavk8/qewEMSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QU9hDdJbW15b1/Q8RFHuRu4QdUDLpYG4iyArEW+o+oOTvrL/83j6OQVrjlgEe5VEA
	 ATU5z20iG7m93VGXaj/w5ASj4F9QInQvgPgZAlYxpZlHtjZoPD2j4poUtGZ03as4zD
	 nKAUEP1qkIkTcAH8Owwqgd2g3KHVu/6KXzqtMlA/hAEqRyCnJ7mSvEv1QLeXCOyFTG
	 Q2XO+CwK0xtW3iSHdfQahrRHUlhkefqnljohjdUPNvSq10rATguR/kP0fv6zyIrM4N
	 EBMLESJCerg/p9BMCBIKkIAG3j5JYcKwcf0MogHeQY8vm/vJOExzUWmS2iS9fdqzRi
	 TYaTtzv9egO7Q==
Date: Tue, 11 Mar 2025 13:01:10 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Eddie James <eajames@linux.ibm.com>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: fsi: ibm,p9-scom: Add "ibm,fsi2pib"
 compatible
Message-ID: <174171606942.3891717.14409083295355127599.robh@kernel.org>
References: <20250307230822.832936-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307230822.832936-1-robh@kernel.org>


On Fri, 07 Mar 2025 17:08:21 -0600, Rob Herring (Arm) wrote:
> The "ibm,fsi2pib" compatible was originally in the binding, but it
> changed to "ibm,p9-scom" in the end. However, both compatibles are in
> use, so just support both.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/fsi/ibm,p9-scom.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!


