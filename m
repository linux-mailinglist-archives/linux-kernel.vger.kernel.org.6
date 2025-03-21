Return-Path: <linux-kernel+bounces-571431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6DAA6BD0E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABBF43B210C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444FD1CDA3F;
	Fri, 21 Mar 2025 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0Yk+j/Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19E37D07D;
	Fri, 21 Mar 2025 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567679; cv=none; b=mCoJq+7SRrVYosVWnDs6Wet7C/1e1JE86GiUg5VD/Zcscpha3Nf4iWs2fd8sN0BDcQV8AVTppitD1XkdeuXXn7chj7VH/sm3Uc8T9SyXLZ4dCDuDRD4usJdcm9ZsEFuTbemBfuse4M7M6aDNzCrniq7LLe6iSEugdNySvgBBLhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567679; c=relaxed/simple;
	bh=ncUdgGT8J7AIZ2KnPWf1uNaVh3x3t/nt+3RArU3kK1w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r/uLkXyt1BaUy11ZZ3DBjfWsDu9q0YBFUIKKSRHBFGaJOPFD3WGFxCPVqV/ioPIFVJQQv0mJjq2/oEhPNv4nqUmAlDlsaVo68vhntdR1ypsX1PlOvANw+FRqcxjnBVTwpEjnBvogIatjcIFIe0dBmetXsxWXJJZRkR2V3PNfWFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0Yk+j/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02646C4CEE3;
	Fri, 21 Mar 2025 14:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742567679;
	bh=ncUdgGT8J7AIZ2KnPWf1uNaVh3x3t/nt+3RArU3kK1w=;
	h=Date:From:To:Cc:Subject:From;
	b=S0Yk+j/YoTYKkgQSlqZtooOsMJq69c87rAg3lRGyeWoTypoYl4ioc1SWYKmXaLPb7
	 JrNVkEkiffOtniUvH3nQnbPdlbFP5F+wUm0fflO+1tTfBTkn+dfzuIKDF/AONCXvjJ
	 mobtlupeit3A3eciVogNzVUhBAKlO8oKlog8pGTKRgX+IY7z1lEJf6G3ZDgC5MVGgZ
	 nlz1sONyc2w+mZrnipxA6HJjhtWbnRiygL2/k6BfENttEfoD1YzW1qxEpVHdbgGVeF
	 yesEZuUUkVsZrF4qGK+AIiqJsF6Ano3KgyNC951uIOijuEnThcfWURpDIlVUfErskO
	 aNgfyk45ke/CQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tvdSL-000000000dQ-2RUH;
	Fri, 21 Mar 2025 15:34:41 +0100
Date: Fri, 21 Mar 2025 15:34:41 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial update for 6.15-rc1
Message-ID: <Z915ASU5AKnAigu1@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 0ad2507d5d93f39619fc42372c347d6006b64319:

  Linux 6.14-rc3 (2025-02-16 14:02:44 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.15-rc1

for you to fetch changes up to 6a7713ec5337d3a535a1e35a7a7a71020436770e:

  USB: serial: mos7840: drop unused defines (2025-02-17 10:59:28 +0100)

----------------------------------------------------------------
USB-serial update for 6.15-rc1

Here's a single USB-serial cleanup for 6.15-rc1 that's been sitting in
linux-next for a few weeks without any reported issues.

----------------------------------------------------------------
Johan Hovold (1):
      USB: serial: mos7840: drop unused defines

 drivers/usb/serial/mos7840.c | 13 -------------
 1 file changed, 13 deletions(-)

