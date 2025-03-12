Return-Path: <linux-kernel+bounces-557236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B28BCA5D576
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85148189AC43
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 05:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E971DE2C7;
	Wed, 12 Mar 2025 05:20:13 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E00F9D6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 05:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741756812; cv=none; b=SCDUFH5vPvaHlRqKlsVhilDlQpyzW0kmciWzq4ASrA9+wqlqfCVSevMhmvTfLFINre+KpB2NrQt1g9eLCqoAXovNvKenQvCVC1ZrG0H0wRCxRZ/xssktDZ7NKJMR7tF424jKWsDasWxuPj1r8rAEVe1KoE5FhDljecvoihukKmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741756812; c=relaxed/simple;
	bh=ngAEhgKY4Clg2d4DtzVaHOsEC7Gc3MfDDpegS4C4r/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVpLGTESLEoh8hVAckXBWfb71fCwfuerCnlydTW7JPYPOEpATDWAsrQAShsBbhUpn+BvKSIho4hwwNHj2Rhp8ES2gHoXsOYWVBOFVQ7xQSSijuvcbNfqH/B3jepV5jCfQDQKeh8NCsFt/IjSRFYMacxLLi6vtKtOAi9kLDtpkyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3C2DB68AA6; Wed, 12 Mar 2025 06:19:59 +0100 (CET)
Date: Wed, 12 Mar 2025 06:19:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me,
	loberman@redhat.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, emilne@redhat.com, bgurney@redhat.com
Subject: Re: [PATCH 2/4] nvme-multipath: add the NVME_MULTIPATH_PARAM
 config option
Message-ID: <20250312051958.GA11824@lst.de>
References: <20250228032541.369804-1-jmeneghi@redhat.com> <20250228032541.369804-3-jmeneghi@redhat.com> <20250305143353.GB18526@lst.de> <03e7cc64-fafd-405e-a07a-4bc6d0e1d743@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03e7cc64-fafd-405e-a07a-4bc6d0e1d743@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Mar 11, 2025 at 10:35:40PM -0400, John Meneghini wrote:
>> What's the point of adding yet another confusing option?
>
> If you'll read the kConfig description, hopefully it's not confusing.

It still is.

> The whole point of this patch series is to remove the core.nvme_mulipath parameter.

Why would a compile time option be preferable over a runtime one?


