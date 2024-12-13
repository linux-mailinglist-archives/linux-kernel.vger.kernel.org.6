Return-Path: <linux-kernel+bounces-444403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509C09F063E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F33281FCC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 08:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254A61A8F7E;
	Fri, 13 Dec 2024 08:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uS041L3r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6F519993E;
	Fri, 13 Dec 2024 08:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734078155; cv=none; b=FqhxQYvyK8CyPNb2f4aG7y8yHFDmc3Qt5hFSupAFQ3+TFg8rSyD4smsaILHyAY1RQ7kN2VvFEyIi8ltU+y0dRalxRjrunKXY3JIXeD9sc8hQAb8NPOURNcpigtQ0nlUAa3xavRhMQHX9XbulXf1rpBCiNUjVo/x9na1Kbj5Xk54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734078155; c=relaxed/simple;
	bh=uOhbAb5QnGoIVZflKGC/Ie5Z1kv3vZwEyXFU6trx9co=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QFg7u6K/QGBMUFIU3b4XO2sOEytwviHNtsvV2a/R5FP2wcLP2L8hsIfuwAUtrdcQfzXkN3LnrCWSeiifDl7/zGuSLHJYjoxhVva3Js268n7arr9HCWYxbWX3tSBE6gES6TzaW1RkgYEQH7q1ssZ5t/fj+wwXn68xl0SItRU1rwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uS041L3r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21CDC4CED0;
	Fri, 13 Dec 2024 08:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734078155;
	bh=uOhbAb5QnGoIVZflKGC/Ie5Z1kv3vZwEyXFU6trx9co=;
	h=Date:From:To:Cc:Subject:From;
	b=uS041L3rnRTeeT0lLzT9ha6IvKxCrViTMiFVXNLHsmIEOQ0NsYLbalWhlAVTnZAWo
	 yckeSUdmV32i5nZ5WM17ENWD6pKzLui/+y1orIvXOlg3qJy5bKVmRTvetxWqypGCpD
	 WD7Nxm8V4GpKfVfW88kZOr6Y+wF/tnQbiCET5hycZd63PUAeXUUzCGM4e1OmS27YZX
	 0aiPpZdy9H8ZzpGmSs3cUOQ/8R+FaDqzTK9nE9AjdYgdFsGq2bqhbNJHDQM/+bjG8r
	 a1N/kRXlCg0K0E68xVzcCymylaoAFWEByi7NcEHtXtyeXLn3LXLj0iZkc0hPMG13ek
	 hSJnhiqIiDAsg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tM0wX-0000000088K-1lWO;
	Fri, 13 Dec 2024 09:22:37 +0100
Date: Fri, 13 Dec 2024 09:22:37 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial device ids for 6.13-rc3
Message-ID: <Z1vuzdjd6mSrgrZq@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.13-rc3

for you to fetch changes up to 8366e64a4454481339e7c56a8ad280161f2e441d:

  USB: serial: option: add Telit FE910C04 rmnet compositions (2024-12-11 10:37:28 +0100)

----------------------------------------------------------------
USB-serial device ids for 6.13-rc3

Here are some new modem device ids.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Daniel Swanemar (1):
      USB: serial: option: add TCL IK512 MBIM & ECM

Daniele Palmas (1):
      USB: serial: option: add Telit FE910C04 rmnet compositions

Jack Wu (1):
      USB: serial: option: add MediaTek T7XX compositions

Mank Wang (1):
      USB: serial: option: add Netprisma LCUK54 modules for WWAN Ready

Michal Hrusecky (1):
      USB: serial: option: add MeiG Smart SLM770A

 drivers/usb/serial/option.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

