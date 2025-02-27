Return-Path: <linux-kernel+bounces-537269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5240BA489D5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 026C93AE641
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C61B26FA59;
	Thu, 27 Feb 2025 20:26:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0F626A1A4
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740687966; cv=none; b=H46IrEpd2fWYJPmE8QFOCmQjpIsAh323r8E+mkQkqjFQsmCy+oxmLs31bPnUSZAO4NCvvQwiljzkxU+xhpffVlk9w9psbTaJ53zS1XzO+BLG7AvrT39+VCauJbNSSl0SxZuO1gPqG6po61VG+FAZ5Muv1uXgh6GBq3Osvj3XAmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740687966; c=relaxed/simple;
	bh=drGbI7MXeidstezmlwRHaw42Md50B8JUUxRUva8Crw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChCgei1rv9ngTm+I0TQ7GIIs8Ktp0SYt92NW7iklqNDHrMqHtXyrGjASiEJQ+S/s1Jfo+S4Ka0LehfUwWHgH47pbe6bqBbtbk0vzXJVBQ70K4DpoMpaRSijc9sI9whXvaw4GNe4SrOS5RRDrBIH2DRo2LXI3S7hLNpCJvfZ0olc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E46DB1516;
	Thu, 27 Feb 2025 12:26:18 -0800 (PST)
Received: from bogus (unknown [10.57.37.210])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FDAB3F673;
	Thu, 27 Feb 2025 12:26:00 -0800 (PST)
Date: Thu, 27 Feb 2025 20:25:57 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Sebastian Ene <sebastianene@google.com>
Cc: catalin.marinas@arm.com, joey.gouly@arm.com, maz@kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, oliver.upton@linux.dev,
	snehalreddy@google.com, suzuki.poulose@arm.com,
	vdonnefort@google.com, will@kernel.org, yuzenghui@huawei.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 2/4] KVM: arm64: Move the ffa_to_linux definition to
 the ffa header
Message-ID: <20250227202557.d3fd6ylzbaho4pvx@bogus>
References: <20250227181750.3606372-1-sebastianene@google.com>
 <20250227181750.3606372-3-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227181750.3606372-3-sebastianene@google.com>

On Thu, Feb 27, 2025 at 06:17:47PM +0000, Sebastian Ene wrote:
> Keep the ffa_to_linux error map in the header and move it away
> from the arm ffa driver to make it accessible for other components.

Do you plan to push/target these changes for v6.15 ? If not, I can take
this patch with other FF-A changes in my tree for v6.15. Otherwise, it
is must go along with other changes.

--
Regards,
Sudeep

