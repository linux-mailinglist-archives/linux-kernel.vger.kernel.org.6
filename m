Return-Path: <linux-kernel+bounces-233704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936BB91BBC4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0942FB20CB9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CB8153561;
	Fri, 28 Jun 2024 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6ClajfS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EB613FD9C;
	Fri, 28 Jun 2024 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719567842; cv=none; b=Kh/A/J421dN2FwLexQYkDzdqGVfZZc9TtlhwjsCHHyDYForEnzjCoBPdvMn9WUVvUw7XbCAW4nSlsC4zGzsYME5p1hAnjqJIFYUhekt5liwpoCzD3OJ7n8Yj/JMTcT6JSRW/W2yeln0/wPvdaOBfX+PkIDgbaseYBBWLlbiAd04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719567842; c=relaxed/simple;
	bh=LMqrYZWI7huyrbGD8y8K+dpqhCLJ53xdbFZvWEqytFo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Sy9lrpf/kRLv1g+/X6c1jxK+lnY+mt0E2IYusK6RuWA9lMObGb7PBHWeOUUpc/t+2wd/KfiaTiasWHJ2hblB7EQ7k7YOUUZqnwCk4G0pQIGo16FOaB4h0em7cPpCoR0RHOVh5iV5QbeDUMbfXqwi6HjPsZKUxjiiJ7HKlLdbcCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6ClajfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B8EC116B1;
	Fri, 28 Jun 2024 09:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719567842;
	bh=LMqrYZWI7huyrbGD8y8K+dpqhCLJ53xdbFZvWEqytFo=;
	h=Date:From:To:Cc:Subject:From;
	b=R6ClajfSddVU53IfeRx3A7dK12IKCDe1kLzWq0MNdDY8ZyBXAb3JU2+DPdMlrOEY5
	 +/6jIZId3a+CQDCylh9ranKu9IWe8zGgFNkFxUL5uyvFs6Ce53HpzLbIq+hHJLExI5
	 s6Xci3jhcwQdRIZvFDAH+TFp0Kp/YQlVxStFYzJqVR/x3nNuwZcSdHL0B6r8c6zwcv
	 nwQYQwTbuvDKAs0Ivj+Zcp7i+tu+aMacl8NJogX3EnI/kQ1Iz4Fw181szVboSfD+za
	 0AEoFwmB6YL0KwOF4SzXwBFDxW2mHncKTr40ActLDrb/YlSCOpL+xFVUhAeRBAmuYS
	 DEBxOwo7IDMBw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sN89S-000000001FL-1YJw;
	Fri, 28 Jun 2024 11:44:18 +0200
Date: Fri, 28 Jun 2024 11:44:18 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial device ids for 6.10-rc6
Message-ID: <Zn6F8mJteD81GsMV@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 6ba59ff4227927d3a8530fc2973b80e94b54d58f:

  Linux 6.10-rc4 (2024-06-16 13:40:16 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.10-rc6

for you to fetch changes up to 4298e400dbdbf259549d69c349e060652ad53611:

  USB: serial: option: add Telit generic core-dump composition (2024-06-27 12:04:33 +0200)

----------------------------------------------------------------
USB-serial device ids for 6.10-rc6

Here are some new modem device ids.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Bjørn Mork (1):
      USB: serial: option: add Fibocom FM350-GL

Daniele Palmas (2):
      USB: serial: option: add Telit FN912 rmnet compositions
      USB: serial: option: add Telit generic core-dump composition

 drivers/usb/serial/option.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

