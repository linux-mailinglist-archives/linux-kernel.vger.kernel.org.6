Return-Path: <linux-kernel+bounces-534547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BBFA46859
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18A117187D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C94E22540F;
	Wed, 26 Feb 2025 17:44:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D7914A627;
	Wed, 26 Feb 2025 17:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740591895; cv=none; b=pzih0Kys0LbeN5818DNLuSAZ3SFPH77IYQMkTfTnKicl9xBL2dXtWt5eTS/H8ajxm6qPqlXbzB6jnaEMV92bDIYS2pJ8nyKtuv+m5fsBpQSaKFqHchaIRCJso3eHK3WVVNgSNhhsxqYcQq+7GWjIVFqamRRRSpQqlfpkdS5sQC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740591895; c=relaxed/simple;
	bh=7KZCq5ZoIpwhSzkYBRP4zr3VqshchApjBPRmGlV7LVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvfQHXwTnSq8XOl+zujMYt3QvYNcB9suuvv63NBXvsShu8IzsH9F5XGA/nsaVOATDhWXjWCEhsbkiFasgJEiPJG/JvRu5bQ23S1+w0emiag/Tl2FgdqtmbSlSyeFNaelWIh/OVUidphgg8YXBDYE6nvSTJnpW+AIlJcaV9g6fPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704AAC4CED6;
	Wed, 26 Feb 2025 17:44:52 +0000 (UTC)
Date: Wed, 26 Feb 2025 17:44:49 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Rob Herring <robh@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Eric Auger <eric.auger@redhat.com>, kvmarm@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 7/7] arm64/boot: Enable EL2 requirements for
 FEAT_PMUv3p9
Message-ID: <Z79TETeXBDG_c8ep@arm.com>
References: <20250203050828.1049370-1-anshuman.khandual@arm.com>
 <20250203050828.1049370-8-anshuman.khandual@arm.com>
 <Z7x-EDH9QP7g4lC6@J2N7QTR9R3.cambridge.arm.com>
 <2ca1dc13-cd5a-4597-9733-2343e05f53b3@arm.com>
 <CAL_Jsq+dJiRLNM_QE_r6HOg7hEkJCPR6j-TGBpiJZLd+RDBbAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+dJiRLNM_QE_r6HOg7hEkJCPR6j-TGBpiJZLd+RDBbAA@mail.gmail.com>

On Wed, Feb 26, 2025 at 11:14:57AM -0600, Rob Herring wrote:
> On Tue, Feb 25, 2025 at 12:17 AM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
> > To summarize
> >
> > - Update arm64/booting.rst regarding MDCR_EL3.EnPM2
> > - Add above mentioned "Fixes:" tag and "CC: stable"
> > - But should respin this patch or send a fix up instead ?
> 
> It is not applied yet, right? So respin.

It's applied but I'm fine with a respin, especially if we need a cc
stable + Fixes, it's easier to track.

Just don't repost the whole series, the first 6 patches are on the arm64
for-next/sysreg branch.

Thanks.

-- 
Catalin

