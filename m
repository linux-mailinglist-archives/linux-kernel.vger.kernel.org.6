Return-Path: <linux-kernel+bounces-371421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5B59A3AD6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51B0A282E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B636201021;
	Fri, 18 Oct 2024 10:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdDpLPar"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D6D1F12EB;
	Fri, 18 Oct 2024 10:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729245961; cv=none; b=h4PcCyse6UVf2T2/Rgj91Bj0HJBVY/xgdrPwlo0jZc7kZS/FhDoNjSD+d5wazYsrpAjUw3MZl6TU+Ja9FfxqSJdWE9zz2kJaoiNDgh5mhHLlc0mqhQ7N0QCBsjlTfji17AePeotIwZmODnwC7hzBhJ/7ygp4qERsYApnn9rzr5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729245961; c=relaxed/simple;
	bh=NgkioI19Na5ZnEfXhq5rfeVLYlydrQkCU6hBQ2+bx0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tItZmEoZ/CUoxDaRHao1FAjyqzbcWGWSXItvDvkxno4Tbqufavrr6KhiMNnunOwDAwSw4VnekgQaCIHaH8PrunNcQu4KRmBzsR2hbXDwl4U9vKWKlDf81jJaGuwl41pAcrODO36VtEk1IdKGCD3Y0SSAyc6GqeK5LFgV1SF8QHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdDpLPar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776E0C4CEC3;
	Fri, 18 Oct 2024 10:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729245961;
	bh=NgkioI19Na5ZnEfXhq5rfeVLYlydrQkCU6hBQ2+bx0Q=;
	h=Date:From:To:Cc:Subject:From;
	b=QdDpLParPUiFuff/ZFe7+IIFM7jNG2m9TaOAtca8M5+sYE/0ni0mwKvOtvWgNmVfx
	 k0TR01rsJ/BEEaDNsqKRyxWNz9GmAHir9Yafio5kmPByM+naBvvbqWdxByqqWhMYgS
	 /1Y/+kj7e8bLefW40zu5chCp9k/WrcSGvUfTRQgDuX45qHUy96aT5W10PxgrtbNxyM
	 51eA6QkIZZIYZbgnl3D+RrltqvBUvcyQJafoJYc5jXaYnDXjEU7UHuTv2fGzc8IgZr
	 vvDRon7/ltubVjCRfRdH9syHXm7MRnzaVwKvRMDXLTBSJm6FruYL1Heaz5CkBy4FpT
	 2FK4ojyLwwAZw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t1js3-000000002yd-1Skv;
	Fri, 18 Oct 2024 12:06:11 +0200
Date: Fri, 18 Oct 2024 12:06:11 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial device ids for 6.12-rc4
Message-ID: <ZxIzE4E8iwpVvpFj@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8e929cb546ee42c9a61d24fae60605e9e3192354:

  Linux 6.12-rc3 (2024-10-13 14:33:32 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.12-rc4

for you to fetch changes up to 6d951576ee16430822a8dee1e5c54d160e1de87d:

  USB: serial: option: add Telit FN920C04 MBIM compositions (2024-10-17 16:38:02 +0200)

----------------------------------------------------------------
USB-serial device ids for 6.12-rc4

Here are some new modem device ids.

Everything has been in linux-next over night with no reported issues.

----------------------------------------------------------------
Benjamin B. Frost (1):
      USB: serial: option: add support for Quectel EG916Q-GL

Daniele Palmas (1):
      USB: serial: option: add Telit FN920C04 MBIM compositions

 drivers/usb/serial/option.c | 8 ++++++++
 1 file changed, 8 insertions(+)

