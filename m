Return-Path: <linux-kernel+bounces-173347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA89B8BFF28
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8040C1F21635
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BD412AAD5;
	Wed,  8 May 2024 13:42:05 +0000 (UTC)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5985312836A
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 13:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175724; cv=none; b=UNWZAd2vR8InJFsg4uosl6car6X60wzkMfoKUkVgpXCTK8aJZgY+wBqt3BIgSUQvb6nECoXZJXfwhISZDwK7lxXN8CNaArIqKHUBTESTOaBoMi2EhF11G0TAkcbo5CqE6FJRasXU3Klq/GynUGXFtMmczTgmyvmZ5Ax1XLI1AS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175724; c=relaxed/simple;
	bh=R3pj01mpVzzwsDrMf0so1PId8hUDV2RIpJUsaOtxsgw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CYaHjReZbVWctUjWd8M7VwKu5iulClhnGikTFvvU4Z/MgJjVWG1PiIoJVtnaVReYrulVS8beyuSGr60ieND+OrmJBFNKzshvaNV7829z03Tui5xGe2k5arokaW8hMrthdBKe+cR4XCeXbHzg87Vt2L590jCD2qbrtgcpB8AOnJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VZGXW02Fnz4xNH;
	Wed,  8 May 2024 23:42:02 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: rdunlap@infradead.org, arnd@arndb.de, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, Yang Li <yang.lee@linux.alibaba.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240408053109.96360-1-yang.lee@linux.alibaba.com>
References: <20240408053109.96360-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next 2/3 v2] powerpc: Fix kernel-doc comments in fsl_gtm.c
Message-Id: <171517558552.165093.5326367473907742082.b4-ty@ellerman.id.au>
Date: Wed, 08 May 2024 23:39:45 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, 08 Apr 2024 13:31:08 +0800, Yang Li wrote:
> Fix some function names in kernel-doc comments.
> 
> 

Applied to powerpc/next.

[2/3] powerpc: Fix kernel-doc comments in fsl_gtm.c
      https://git.kernel.org/powerpc/c/97bd2693b399cfd436acaa230d8f09e4c39e8e5c
[3/3] powerpc/rtas: Add kernel-doc comments to smp_startup_cpu()
      https://git.kernel.org/powerpc/c/554da5e0f71238384787954242d881cfeeff844d

cheers

