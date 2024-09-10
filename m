Return-Path: <linux-kernel+bounces-322403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C879728A1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83B5DB23C2A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29BF1531F8;
	Tue, 10 Sep 2024 04:52:38 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88B614D710
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 04:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725943958; cv=none; b=G7bfCKc5pHCZsT9oCHLBeFN+74ccTKwVB99OFPWsihcGTgd0jrIm0Bcp/BsFFYmDdZYf38Utt1enLFGMma8pDEcvXUbW8L7weu6lLtTwhxk8DiSV4WDmKyFTUCzVGsjpvgZSQT2JvEddA9j7kUhlLzW9XD8+MMKXUoskSzG9dY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725943958; c=relaxed/simple;
	bh=oQ2Oy2vE4Y+KSIGzjxEVBp2pts3FTmVlEXlZ7nc293g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDpqmFYbPbfFCkVnHWStJjh3QBbe08BMrXOciC2ieWSabdK9rzhRqBMrz/E4AQka1CmOJQjftYzZAXxlsX37nmkdNCB4K5Q35OkMJ3/nu2nrX/2+KIoE5aSGq8GaQAAaVGF+cd6r0qvYbCisC2sdADO87bBsa5cVwM1qrNnNY00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C99E4227AAD; Tue, 10 Sep 2024 06:52:26 +0200 (CEST)
Date: Tue, 10 Sep 2024 06:52:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dma-mapping: add tracing for dma-mapping API calls
Message-ID: <20240910045226.GA15967@lst.de>
References: <20240906215435.636352-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906215435.636352-1-sean.anderson@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks, applied.


