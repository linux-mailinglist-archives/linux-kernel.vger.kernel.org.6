Return-Path: <linux-kernel+bounces-543756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C83A4D96E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 024407A4DCB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A021BC2D1;
	Tue,  4 Mar 2025 09:57:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E885D1FCFD2
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 09:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741082249; cv=none; b=TP1PGa9cqtfGKe3rLhCcZa5lu79Tzua/28XoIUdl/DMOMNPlZ/ggcIZgLlakWaLfSO3F9hjw4UpLoT4ewF/idshxUOvo50tiacGaMo4EF8lKPwoRTyjnm+gEBrV+4G4mpRGA/nspb89lhEt4Lth1j4+LnNDKtHy/8oaSlFsHqco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741082249; c=relaxed/simple;
	bh=R5+chWX4fjfkhsjJuY4Smqs/2zQtO3ZQY823JD8d1Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuKB8JYlNhRjqEmVC9t75jKOaP+ofySNdh7Y8yS42VqvLLttebqu2t1Y83XGsnQGhJAFXY+TNAfB8g/dDHqgTr+6jQBMCLt3bFo10Fh+SuLXQ3COQCI7FQfNzMs83fSVQ2LaT/57Q6u5ra6KyznWJloxiuRSzn3GkKv0HuyMxi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DA69FEC;
	Tue,  4 Mar 2025 01:57:41 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBCCB3F5A1;
	Tue,  4 Mar 2025 01:57:24 -0800 (PST)
Date: Tue, 4 Mar 2025 09:57:21 +0000
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
Message-ID: <Z8bOgetwikZQnUqy@bogus>
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
>

If you are reposting the series(which seems to be the case), please

s/KVM: arm64:/firmware: arm_ffa:/

 as it is not strictly KVM specific. With that, you can add

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

