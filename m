Return-Path: <linux-kernel+bounces-243402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF7E9295CF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 01:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740B71F219FE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 23:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDD913DBAC;
	Sat,  6 Jul 2024 23:13:10 +0000 (UTC)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9FF7C6C0
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 23:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720307589; cv=none; b=pWCo35HO6smaXynT44o4Nh5HL1wymXnMZwKUOySNJCJtuY8q3lh8VRjKAxbg7UQSv81GNBYnooyi5yHyJbFgHxoVNUH0BB/R7DaV7/OuOU9pqAvtt/ZbzRV3/PO6t/QY8unatUsp15pvneUW1lyQnQxPEiWEnjUjXhXbOkzThds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720307589; c=relaxed/simple;
	bh=AJvg/N/wNxSFtV9KoqPMTNbaKHCEl5oTdQvBYofMVIc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lxoxEhpaMJRgiyeMLcWBKXGz6QjcxVqUiNBkbvwpReIJG7H4v3IZj1oBanDA5KVcx5POaIuGf3g2PZF/RGdNI6OgRtu4kcsjpN9G8JFuKfkdQOJLqNCHlPFw52YNETd279JR8tFPFzaKprx8MW8XibQl0P187AP0US3B/bJ2n1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WGmQ50JNQz4xPg;
	Sun,  7 Jul 2024 09:13:01 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240702210344.722364-1-robh@kernel.org>
References: <20240702210344.722364-1-robh@kernel.org>
Subject: Re: [PATCH] powerpc: kexec: Use of_property_read_reg()
Message-Id: <172030740416.964765.12728805130197290017.b4-ty@ellerman.id.au>
Date: Sun, 07 Jul 2024 09:10:04 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, 02 Jul 2024 15:03:44 -0600, Rob Herring (Arm) wrote:
> Replace open-coded parsing of "reg" property with
> of_property_read_reg().
> 
> 

Applied to powerpc/next.

[1/1] powerpc: kexec: Use of_property_read_reg()
      https://git.kernel.org/powerpc/c/cf08b628cd146a3cb597999f4d4dc590068bf011

cheers

