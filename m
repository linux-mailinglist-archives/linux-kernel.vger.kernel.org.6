Return-Path: <linux-kernel+bounces-406415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5E79C5EB9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44BCD281A3B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D23213EE9;
	Tue, 12 Nov 2024 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRyKbtQt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93F920D51D;
	Tue, 12 Nov 2024 17:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731432008; cv=none; b=ae8bKDjCQGYkp8MpiE0CM66nFXLbRjplJAluyQb58u5eT9rDwOAmKl5JP7cuw+MDUhbsPaWbd7X/dgTXwWqd28WsFUYExIAlEWaAFYblO6A4n5gqpUOx6WPjPN290wFFvpHIdXiV6WmmGnnAJfBIREWi+gFwwuIlbJBeD88ArsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731432008; c=relaxed/simple;
	bh=kxq+Qvpdqa/9pRVF0zI8u+S3KYrRUl+SKH9LeS3DpkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZgu8AZj83usAjMoiz2Df53EdSledUTuZe+RruksuYfWPpvLoMjrMx3bJzovf4FkgvvAWxpYjsFfqbuSt/Dr5B3Ju6CYIfYCShxfl3xqTJDLILO4rB3UpdBP73RHHNDwnXpjB8OyuiU1ob681p8khetk6+YPudKuozBfjbuJ15c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRyKbtQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E38C4CECD;
	Tue, 12 Nov 2024 17:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731432008;
	bh=kxq+Qvpdqa/9pRVF0zI8u+S3KYrRUl+SKH9LeS3DpkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CRyKbtQtD8NAKajudiu2KWgR4VZpUlT/8Qgfzw+XVK01L/f+kGeImeLxFwlIsHI3s
	 d4803isCaNZahYJDHsGYnOOJN2hChGvnts1cFG0goR5b0tsMZEt27iqk9vC66LdbK5
	 U5RYMSL7snOeoqILBRtX4j82EEFTFYhEaYJRd/cAQmnP6lsZjlF5llzrH0ZMGY9xDk
	 OtMGqvQGe2twSC/7UK+ix7lJFLbYXF5F7C4iF9SF2ZknY6gVp+YJS95C/FYx2StVll
	 0K7CDt+q+5oOo5/8Ov71mepdTxLAQnuMmGCuUpws/Ne6DoYEsEej49gLqFSEuDUWBa
	 tVtdQEbZf0/iw==
Date: Tue, 12 Nov 2024 11:20:06 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
	devicetree@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Trilok Soni <quic_tsoni@quicinc.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: arm-smmu: Document sm8750 SMMU
Message-ID: <173143200549.1352576.7660253310575127437.robh@kernel.org>
References: <20241112003217.2806556-1-quic_molvera@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112003217.2806556-1-quic_molvera@quicinc.com>


On Mon, 11 Nov 2024 16:32:17 -0800, Melody Olvera wrote:
> Document the sm8750 SMMU block.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
> Changes in V3:
> - added additional documentation for gpu and clocks
> ---
>  .../devicetree/bindings/iommu/arm,smmu.yaml   | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


