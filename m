Return-Path: <linux-kernel+bounces-250660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF3C92FABA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B627B2209D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA45716FF5A;
	Fri, 12 Jul 2024 12:53:56 +0000 (UTC)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08D18F58
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720788836; cv=none; b=MrtU6oHtH5wESJ7t9sq06rrDXmOfIOecquPdz12uZAZo7s6XT+AMA75xYS2pGjh5sCqOVFcz8bvVWBaTl9R9U2myEkiKNcWU7VWjkPiAelmqCPdkGqTEMx79zORzs6L+DcIUVuxB3O/mEeh7d+ZCugMu3wiifM0pJjvh4aQBHcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720788836; c=relaxed/simple;
	bh=FvTL+4M1+BNimn+VUCXkx6CvZ/Xfa8z12Q3birBWV4A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bTAcnzP+xa31KEmO5I/TTeLf5zMisLicYZCIPNEKhKOhbP26xE2BuxUDPiqQfuNqUN/LucYlZ4PEVzdaHm8WH8sXsBTyxQ9AbzD+1vSUXrS1jqOB6GMAAdbcJ8r/vuz3d56pdG3HX96ciWE5vYSFVXOKsjRdiu+aLe+6wqtjJks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WLBNw5VJRz4x0t;
	Fri, 12 Jul 2024 22:53:52 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <ab30ae302783d8617d407864b92db1b926ab5ab9.1720694914.git.christophe.leroy@csgroup.eu>
References: <ab30ae302783d8617d407864b92db1b926ab5ab9.1720694914.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Remove 40x leftovers
Message-Id: <172078879461.310795.8861994461453100289.b4-ty@ellerman.id.au>
Date: Fri, 12 Jul 2024 22:53:14 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, 11 Jul 2024 12:49:01 +0200, Christophe Leroy wrote:
> 


Applied to powerpc/next.

[1/1] powerpc: Remove 40x leftovers
      https://git.kernel.org/powerpc/c/3efe19a9b15411119d4a35ec5790ad49f0a0234c

cheers

