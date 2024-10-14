Return-Path: <linux-kernel+bounces-363841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 379E899C7C2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1D171F21207
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EBA1AAE09;
	Mon, 14 Oct 2024 10:54:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0861519C542;
	Mon, 14 Oct 2024 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903264; cv=none; b=lpOO2LWpvw62T7/qxYo64IB5vwSseAo65uWfikMX9VwtZUOFQQnK2yrbQQaz3jgeGgDzXPc4W7q0RDlFs0ceYShcM3af1lfZFLaMQM1O1zOQDTfEUO+4CIpsSOtG7ui9HUPhXYezntSeBj0bNzu9SGQ/u1dDVrz71Yz465+mj3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903264; c=relaxed/simple;
	bh=opz5cpPv+rZrq85DfTyAqYLW6lqitdbazxqQpuQWIKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlxOMAJ2+WDuqrzN0aQ/9+WHFd5BSxXwuT1w1WaoCe1wTptzdQ2Q/Wn6yuBM70Xo+EbHPiFofEcutboOa9Vy45PRtpMewCIPo43bFWKGUL3UM/O/Vwji2D9xsqBpIOJVg42XGuzVyzeVowYbf3SKM/MxFtFLqxPllpoyPHDRBC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE2561007;
	Mon, 14 Oct 2024 03:54:51 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 199413F51B;
	Mon, 14 Oct 2024 03:54:20 -0700 (PDT)
Date: Mon, 14 Oct 2024 11:54:18 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: cristian.marussi@arm.com, quic_sibis@quicinc.com
Cc: linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
	johan@kernel.org, konradybcio@kernel.org, johan+linaro@kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: Skip opp duplicates
Message-ID: <Zwz4WpPodFP0mbl0@bogus>
References: <20241009143905.2440438-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009143905.2440438-1-cristian.marussi@arm.com>

On Wed, Oct 09, 2024 at 03:39:05PM +0100, Cristian Marussi wrote:
> Buggy firmware can reply with duplicated PERF opps descriptors.
> 
> Ensure that the bad duplicates reported by the platform firmware doesn't
> get added to the opp-tables.
>

Hi Sibi,

Feel free to add my review tag when you post this as part of the next
version of the series.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep

