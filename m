Return-Path: <linux-kernel+bounces-563917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C34EA64A99
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E33E3B22E4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460F5242905;
	Mon, 17 Mar 2025 10:35:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D4B24169F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207699; cv=none; b=p7SLqxxugmZqa1ICjHTtaHiF42lP93guzKKfazO39fKv57x1nThNDIYjX6nvvk2rKp4jIqNK2/Z7/TlfaRWLG02M78zfyjHkhP8V89n9NnU1dbn0ExIzZG2QA0fyh9sPh2vC4MYESqUJNz1sTE8BgOmKOnyaW2bufasW4DWtiC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207699; c=relaxed/simple;
	bh=mQFvEVDfpGoh5x6uGmbYUYC59z/W4+ikIREVh1XWseU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=So9JKSbFg1Bd8NSTWUwyj4BfmZXZjyGH4n2vzfNGrttmdl8v3vFrYNvLPQUEVPhvxebUJxsX/GAeEdFWZLFunhD7kHylYAArH37OLbVQsBFm5m6z5EWhYWfCzUnelofQZ6x/4Byd3m1vlH37UeDGxrZ6W8Dt+8pR1xihvyyv/Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DD7A13D5;
	Mon, 17 Mar 2025 03:35:06 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE39B3F63F;
	Mon, 17 Mar 2025 03:34:56 -0700 (PDT)
Date: Mon, 17 Mar 2025 10:34:53 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 9/9] regulator: dummy: convert to use the faux device
 interface
Message-ID: <Z9f6zVGSYNIK2OhW@bogus>
References: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
 <20250317-plat2faux_dev-v1-9-5fe67c085ad5@arm.com>
 <e35ccf12-3959-4ff6-b0fd-ae9374c90de9@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e35ccf12-3959-4ff6-b0fd-ae9374c90de9@sirena.org.uk>

On Mon, Mar 17, 2025 at 10:24:11AM +0000, Mark Brown wrote:
> On Mon, Mar 17, 2025 at 10:13:21AM +0000, Sudeep Holla wrote:
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > The dummy regulator driver does not need to create a platform device, it
> > only did so because it was simple to do.  Change it over to use the
> > faux bus instead as this is NOT a real platform device, and it makes
> > the code even smaller than before.
> 
> This is already in Greg's tree isn't it, what's going on here? 

Sorry if it is already queued. I just checked against linux-next and
posted it as part of this series as I needed it as well to remove all
the "faux" devices under /sys/devices/platform.

I may be missing to check some other branch Greg has queued perhaps.

-- 
Regards,
Sudeep

