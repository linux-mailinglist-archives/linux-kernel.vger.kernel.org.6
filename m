Return-Path: <linux-kernel+bounces-573434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CD6A6D725
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 10:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C5B189278F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E49825D551;
	Mon, 24 Mar 2025 09:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdnUlAlr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061641C6FF9
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742807915; cv=none; b=Uj6OH1oT6BXzLlriJTSKtioNEpXnefN1z9Eo6TYUSW/Z+ZsPqgPXMrr9F6ZqFGfALLk8IRUei2B55x8EBPXcF/Si7GBIrXktLBQjF23ezLGKDDod1v2txy9lhjKgB+i6sMrNRUOueN0cEvIwqj/0KA5ovRGp4Sa3pmlXfsJTWXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742807915; c=relaxed/simple;
	bh=L++YczgvJnIwhkE7OlWisH5OcBd8uFp6Wr4i0+0+raI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnMFq4nHnvLSBqv+X2RxNrB0hdxQ1t4NHegBzKEWKR0rf/WqiRlwvPDTuEvuI336O3ez3UID6KxVd2tGPMkhm1xEWkixICOUl4+HFMJKv7fGND0yI2ltpnRTqZW8vcC3zJt00FXVTqO1f4OoUkNCv6AWz5k6luKo+pQiXbPeZsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdnUlAlr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D79C4CEDD;
	Mon, 24 Mar 2025 09:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742807914;
	bh=L++YczgvJnIwhkE7OlWisH5OcBd8uFp6Wr4i0+0+raI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GdnUlAlrR3eS1Dz0Nc8pSivrXWeW2H1OpCX+t4gyFN3FG4BnHfSYx1rPi3OSGK9co
	 QP1XYxd8lTW79KkUspl8cGigYYt1Fhv5Tms2O8vvjf03pPBsHQkRKl019XS5uxnCVu
	 G4jVDsregR24BPsFOrBfWTEo1GjgAdgq0byWYf9jRAPvo38qJ/nztIvxxzrmo+cwfg
	 opeO06ApxyWKwpJrvPgMW2iz7MmoOeNXpCVu1HVK/I+odexBXvm1d1BkFBt9yooFUw
	 7aJoa+sAMTUlPoraJxRxk/sbPxJmQQrpWttITh6/CSLZ4JGuGKJDeOfq/sqh4OhmV0
	 NVSMJ5+bZlP1w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1twdx3-000000005UG-06ly;
	Mon, 24 Mar 2025 10:18:33 +0100
Date: Mon, 24 Mar 2025 10:18:33 +0100
From: Johan Hovold <johan@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: ath12k: extend dma mask to 36 bits
Message-ID: <Z-EjaQ70mtQwQsgs@hovoldconsulting.com>
References: <20250321162331.19507-1-johan+linaro@kernel.org>
 <0e2060ec-f0ed-41dc-8325-0ec839a59dd5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e2060ec-f0ed-41dc-8325-0ec839a59dd5@quicinc.com>

On Mon, Mar 24, 2025 at 04:33:13PM +0800, Baochen Qiang wrote:
> On 3/22/2025 12:23 AM, Johan Hovold wrote:
> > Extend the DMA mask to 36 bits to avoid using bounce buffers on machines
> > without an iommu (under OS control) similar to what was done for ath11k
> > in commit dbd73acb22d8 ("wifi: ath11k: enable 36 bit mask for stream
> > DMA").
> > 
> > This specifically avoids using bounce buffers on Qualcomm Snapdragon X
> > Elite machines like the Lenovo ThinkPad T14s when running at EL1.
> > 
> > Note that the mask could possibly be extended further but unresolved DMA
> > issues with 64 GiB X Elite machines currently prevents that from being
> > tested.
> > 
> > Also note that the driver is limited to 32 bits for coherent
> > allocations and that there is no need to check for errors when setting
> > masks larger than 32 bits.
> > 
> > Tested-on: WCN7850 hw2.0 WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

> Reviewed-by: Baochen Qiang <quic_bqiang@quicinc.com>
> 
> With WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3 this is working, so:
> 
> Tested-by: Baochen Qiang <quic_bqiang@quicinc.com>

Thanks for reviewing and testing.

Johan

