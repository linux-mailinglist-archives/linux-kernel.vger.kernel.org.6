Return-Path: <linux-kernel+bounces-173337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E8E8BFF14
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 103BA282AA4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136B986151;
	Wed,  8 May 2024 13:42:00 +0000 (UTC)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CAB84FBF
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175719; cv=none; b=EFOl2jpYsptX7jlSa+qnTE8EtgHGBDmkvhXaZ0tvN+ng+xH1+iFP1kdHZzZoqw5wsx9IhLGbJLvp41BNQqjx4aQ7lIPFxMITOEPIAhPAHj9zQ3uALLHEes7B1VYpGrEEc837ZvddcbVSi8G9YL1kyFrwf7C325CbMRNFPmpUouk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175719; c=relaxed/simple;
	bh=w7uDA490K0jxpSQj6UmZbjE9F+1dXsbCH4FLEWtbDG8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j+TdjhsV+oXlPemBADs8f5xYqG5ABQB/2OgUn/5dUZhwVNg6EoU7HzgUD/sTf5/ubPEAnzAtLx30mnkCFvUTi9rfytvMGMvhaO939syBSv3B0bmXRztoi3T8r9qKB5Y1pI9e5uDSN2FDlrfKvBb/5rmhtSwalaApDSseBCBvY8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VZGXN3QSKz4x0K;
	Wed,  8 May 2024 23:41:56 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mahesh@linux.ibm.com, oohall@gmail.com, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <cover.1703756365.git.ghanshyam1898@gmail.com>
References: <cover.1703756365.git.ghanshyam1898@gmail.com>
Subject: Re: [PATCH v2 0/3] Fix typos, grammatical errors and add units of function param
Message-Id: <171517558557.165093.17275880454582090207.b4-ty@ellerman.id.au>
Date: Wed, 08 May 2024 23:39:45 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, 28 Dec 2023 15:45:17 +0530, Ghanshyam Agrawal wrote:
> This patch series fixes spelling mistake in the word "auxillary",
> fixes a grammatical error related to full stop and adds the units
> of the size param in the description of eeh_set_pe_aux_size function.
> 
> Ghanshyam Agrawal (3):
>   powerpc/eeh: Fix spelling of the word "auxillary"
>   powerpc/eeh: Add full stop to fix a grammatical error
>   powerpc/eeh: Add the units of size param in the description
> 
> [...]

Applied to powerpc/next.

[1/3] powerpc/eeh: Fix spelling of the word "auxillary"
      https://git.kernel.org/powerpc/c/39434af10f1045b50826b8b506415f36681d4b40
[2/3] powerpc/eeh: Add full stop to fix a grammatical error
      (squashed)
[3/3] powerpc/eeh: Add the units of size param in the description
      (squashed)

cheers

