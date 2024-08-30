Return-Path: <linux-kernel+bounces-308845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E3196629F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D47FB21737
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EB61A7AD9;
	Fri, 30 Aug 2024 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyOA/UXp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B87188A33;
	Fri, 30 Aug 2024 13:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023303; cv=none; b=MB3+mfSAqkJPYWAh4XFxQDpwVq0QzIprV/S7s/YKKfukEQUND9Sg2//uq+2AebrgW44XI9Jg8DZYW2VfXNHkr2HdEBpUYBib5iqEGjC007z72lrXWK7cwSGlhxt8npIVzDhih6Cp6jz7tU8o6QEU7IRPHOxAwWwhDS3NUhGKXuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023303; c=relaxed/simple;
	bh=QIkFiSZpUX8XxScXU3S4zHB3TYaYoQsh/+Ybl9gQ4j0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=peczFEdmWeNqLNZLPdzLpWVF7aWu8WCy3Ko4Pey6kj6/s9QsXFcPr0bIr3S1sWYFdYgQLtQbMEVksXtkLmsarb3b4Fn5Ss67gr7BnhDRAYupRsfcB4n7C4DCpSF+/X8eF4qlrB3/Ssatpfy5d7gPnY9W71ovUmTDGXJu1ibEL7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyOA/UXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C47C4CEC2;
	Fri, 30 Aug 2024 13:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725023303;
	bh=QIkFiSZpUX8XxScXU3S4zHB3TYaYoQsh/+Ybl9gQ4j0=;
	h=Date:From:To:Cc:Subject:From;
	b=fyOA/UXp3uEyDUOh/8leB5IYnA8aKDYP+vNE0FGLVzCnx/U5d5nqZCGzSghXRKmzV
	 LLxsjN3yxDSPfCHcEhDmXl3DJziNGvwhRUMMmWANclFCNtReFMC0W1zCukT2KzCxLz
	 Ez+cmuQ9fe47eSr7vYAVRRc9rrM72UDfJlnwJuKlwr/Hzl6Fc0Mp3wov5D7JlWQYOJ
	 luYHFKBevyaD+7R+aEdXgo/pRe0hiPtBxoX6jtv16WvK3bgkc+YWORWuXXi7vYerxI
	 SRTiDORVesXc9G5qQNmwFD5eCJbxVjsrCITNNdllpNFKcDCpb83jlOvpxafKJA3zc+
	 JzW0n3XOuV1FA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sk1Mk-000000007r3-0VtW;
	Fri, 30 Aug 2024 15:08:38 +0200
Date: Fri, 30 Aug 2024 15:08:38 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial device id for 6.11-rc6
Message-ID: <ZtHEVr1H6wJqihQT@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 47ac09b91befbb6a235ab620c32af719f8208399:

  Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.11-rc6

for you to fetch changes up to 9a471de516c35219d1722c13367191ce1f120fe9:

  USB: serial: option: add MeiG Smart SRM825L (2024-08-27 08:47:29 +0200)

----------------------------------------------------------------
USB-serial device id for 6.11-rc6

Here's a new modem device id.

This one has been in linux-next with no reported issues.

----------------------------------------------------------------
ZHANG Yuntian (1):
      USB: serial: option: add MeiG Smart SRM825L

 drivers/usb/serial/option.c | 5 +++++
 1 file changed, 5 insertions(+)

