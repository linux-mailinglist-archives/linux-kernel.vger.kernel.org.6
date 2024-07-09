Return-Path: <linux-kernel+bounces-246761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1E392C644
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 00:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062B71F238C0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D91918563E;
	Tue,  9 Jul 2024 22:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7croNvU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE027CF18;
	Tue,  9 Jul 2024 22:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720564616; cv=none; b=KfWPHy/NfKJRKxMPLlc7VT0fNyppHqGwq/yuHUJJAavoips/6/hBBEOZBd+yE71fhJwHDe1tegummWaS5Bc+GFO+gSLCVY4qQjz1m7W+O35NWqHBjl6fQcaWD88jJs9ouP5cK/U+FWXG9TPqrcMBGWjecFLn04VTlpzrhOYggXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720564616; c=relaxed/simple;
	bh=oQAF0gVLkyR7+8e+PzgPB65mG4JfXaXczJoZzxS8y3g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GPLsp8ySwcaGqMIWb3U2FH+oKEu+StoCoYG3KYt6FGyDC6Be3hBFBYD7igkvlOza86bi4er8la8XJi1UW6COpsUhmwLXH8eWUgdXaBEVImHOS6T8FFnMBCAV+yl+D73aHEhrbr7Bzeol52mNRw81hc9IdmFXDcnrcZQ9W/ax3HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7croNvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA60C3277B;
	Tue,  9 Jul 2024 22:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720564615;
	bh=oQAF0gVLkyR7+8e+PzgPB65mG4JfXaXczJoZzxS8y3g=;
	h=Date:From:To:Cc:Subject:From;
	b=i7croNvU1SVcQ/nr42Xqg1kfaN7rl+bbSFyvwYipOd3wZUsb9mrVtoGZQ0/GZSPhS
	 1Z/YKWl6GCYR75W+shWZd6PyrCN6JNKHFuNfpF0IMRBiE8bpVdUhRY2LZUzQ7kSVgP
	 /BoGrf4TAwjkHZ1XTEEuQ/BAgAk8cDOqNNMdNYwDhjGmLTdecFYuTKWTF8pnPZE9N6
	 n8poU2NSVLjn78frSNOK+4w+t3O0beoM861BJ1R1KbqBzALvZRUoq3dde/kF5afljA
	 EeZmKoJmaPNTm+rjnNbZvsa9PB+SqjINfKABQ62AOmaKrPPOQKPkykH5VGvoNVPneC
	 8FINW3kN5KA/A==
Date: Tue, 9 Jul 2024 16:36:53 -0600
From: Rob Herring <robh@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Saravana Kannan <saravanak@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree fixes for v6.10, part 2
Message-ID: <20240709223653.GA1276694-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull this 1 fix.

Rob


The following changes since commit e7985f43609c782132f8f5794ee6cc4cdb66ca75:

  of: property: Fix fw_devlink handling of interrupt-map (2024-05-30 19:43:47 -0500)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.10-2

for you to fetch changes up to 2cf6b7d15a28640117bf9f75dc050892cf78a6e8:

  of/irq: Disable "interrupt-map" parsing for PASEMI Nemo (2024-07-08 15:42:20 -0600)

----------------------------------------------------------------
Devicetree fix for 6.10, part 2:

- One fix for PASemi Nemo board interrupts

----------------------------------------------------------------
Marc Zyngier (1):
      of/irq: Disable "interrupt-map" parsing for PASEMI Nemo

 drivers/of/irq.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

