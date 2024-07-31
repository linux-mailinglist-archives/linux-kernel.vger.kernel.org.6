Return-Path: <linux-kernel+bounces-269744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12220943657
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4499E1C212DC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330D34AEF2;
	Wed, 31 Jul 2024 19:20:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3F53E47B;
	Wed, 31 Jul 2024 19:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722453601; cv=none; b=CtSlqk48+Lf2Hwy9TnSFJiPFc6iZNCrkgtUc6bplA3DeJPyVzVERDamdXpBCKme+h42eOr7EN1RcPx0RmFWAtBd4meeaZnZjqQezi6oGxV5dah/NumYwwUf9sRLYb35jm6lNbkQaJGxMMhmF5oeaCuP99rQ6Pi1Lb+5QkJ2ebHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722453601; c=relaxed/simple;
	bh=Pu4x/CV4TJXGKOW179zhqVu57PY0n3kkSu8JLSbNwL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pu8cjX+T+hT8jBL9X/sdCbgFSDeP3ROc5Zik0ulIKuaqoHru9qQZF1fW4CCT5vyHflz7iJVDT1zuOvWPafMBV2tQg4GHMMFT1GNm5Y6oG06EKbNZE4QqWizitIEMGJ9LH+leKI4h/sEqfQqeYYYUHmJKxgESEHgCG8bz0W172lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE7BC1007;
	Wed, 31 Jul 2024 12:20:23 -0700 (PDT)
Received: from bogus (unknown [10.57.94.234])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D5443F64C;
	Wed, 31 Jul 2024 12:19:56 -0700 (PDT)
Date: Wed, 31 Jul 2024 20:19:53 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: vexpress: Use of_property_present()
Message-ID: <20240731191953.wzbvo2kym326gekv@bogus>
References: <20240731191312.1710417-13-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731191312.1710417-13-robh@kernel.org>

On Wed, Jul 31, 2024 at 01:12:51PM -0600, Rob Herring (Arm) wrote:
> Use of_property_present() to test for property presence rather than
> of_get_property(). This is part of a larger effort to remove callers
> of of_get_property() and similar functions. of_get_property() leaks
> the DT property data pointer which is a problem for dynamically
> allocated nodes which may be freed.
>

Guenter,

I assume you will pick this up.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

