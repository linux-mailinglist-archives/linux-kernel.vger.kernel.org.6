Return-Path: <linux-kernel+bounces-513130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2596DA341D1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1262E166067
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4920281366;
	Thu, 13 Feb 2025 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llstds95"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A1F281353;
	Thu, 13 Feb 2025 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739456637; cv=none; b=Kh4YYW3OZwpUrhY8CJ/1aJC8Nc04hfDFWdf+s0M5hpQ5UPsAE246i2AjUhPKTIk70vWp2EJrcmuknaAGSN6O6ZS/+UZTZ05HOvJnCfnPLcwQBP5siH9ykyEt6RXGUAnNTYo1CI6W8XXMX30c/Y7vdIj2zn8gCCNQVPN/xBnp25M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739456637; c=relaxed/simple;
	bh=cBTRS+nmrHs4JvsqrD627WeGldxDcr6ZnR7AZDCpZug=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A18XOV9Ss5lsP/jsQ/mki3g1jVi7XfvKtppHq3hYdQeoCpAG0+LjkeLpc4ic/2Je7vZQJRdAqodtbKBsyrZq79btviJHqQ6P4kqKpww9dI0ImgKHjMgeI3/5JlyrMyDSZJe3pCIoyTsr8CuXopVnYWeOxKmXqNBMaaRuy+FhTSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llstds95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF8BC4CED1;
	Thu, 13 Feb 2025 14:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739456636;
	bh=cBTRS+nmrHs4JvsqrD627WeGldxDcr6ZnR7AZDCpZug=;
	h=Date:From:To:Cc:Subject:From;
	b=llstds95XRxYEq8Dz4ulB1AduAXBP8oA0Jg3g28QYkglDRKculFtywpv6958sM8h3
	 ijw6VK95/dhUqAQ/vGFx7XRZUlwuIDTYAbi5rKAkC9MMZfkaFRhg7Zurb3NdU/7RO8
	 bDiYwXFQVvhKa1ASIHmNtCaoxbYCe9xzfzIyuDigKchxvQR8VdclcBdFrN6ROXPJRb
	 O+lqIxQhHRcqXK+gw2HLPr7j35tqF+0SE7cZVmQYo4Q3h6qw5K5cJ3+yvhTcZaQ9NO
	 I5/EgOuF9sEwj5C5OEZgK04NM86qLlPt/6AugHbcX1cAqQ6jinggAZUH/pE8XmUzh0
	 YlIYTAJTs23TQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tia8M-000000003va-1WPd;
	Thu, 13 Feb 2025 15:24:06 +0100
Date: Thu, 13 Feb 2025 15:24:06 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial device ids for 6.14-rc3
Message-ID: <Z64AhiS7ENsTHAPb@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.14-rc3

for you to fetch changes up to 6aa8a63c471eb6756aabd03f880feffe6a7af6c9:

  USB: serial: option: drop MeiG Smart defines (2025-02-11 17:08:58 +0100)

----------------------------------------------------------------
USB-serial device ids for 6.14-rc3

Here are some new modem device ids and a couple of related cleanups of
the device id table.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Chester A. Unal (1):
      USB: serial: option: add MeiG Smart SLM828

Fabio Porcedda (2):
      USB: serial: option: add Telit Cinterion FN990B compositions
      USB: serial: option: fix Telit Cinterion FN990A name

Johan Hovold (1):
      USB: serial: option: drop MeiG Smart defines

 drivers/usb/serial/option.c | 49 +++++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 20 deletions(-)

