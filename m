Return-Path: <linux-kernel+bounces-361880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B67899AE50
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4DA0B22EC5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC47F1D173A;
	Fri, 11 Oct 2024 21:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lf9Vm5y6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F715194A67;
	Fri, 11 Oct 2024 21:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728683736; cv=none; b=U9FBUdMq0YSbTfCcbUTb1JmeeYGqmMy/XDWcKrEmKmbzD5fF8og0ktvQzcvj60dF2B6GSOJdJf65wIMLJ0bWq/X4YW06Qw74f9cn+0KZ1j/Idqv0CeIIDbYod36OuvQmi3zfaNxgpPhZRnI6Ws09t62LSoZhB8DoY/iIm8FZkYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728683736; c=relaxed/simple;
	bh=eD71LVrxqwlv2wKWxK9+4d3rK3+9jdnoxnKHogtfupg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Aq4CNwyW16cYQz831G4DARqf8IIV/1sLvjCvM1cz+jMD4uJJDmyNNzkWM5un954w24Wy1Sm11+etgU6d5IV07Y8SVzZav0sSRKqMXQESH64ajf9pV++YHK2XaigFaNTFI6oj1f+ryExWN0QjSNtglVU+h2+zwsQUV3jP/CR+deo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lf9Vm5y6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC54FC4CEC3;
	Fri, 11 Oct 2024 21:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728683735;
	bh=eD71LVrxqwlv2wKWxK9+4d3rK3+9jdnoxnKHogtfupg=;
	h=Date:From:To:Cc:Subject:From;
	b=lf9Vm5y6cv8SzrfaBMkI078RLf5Nhq4JKoktjRxkXDDifMLXzGOdEk52xZYEyf9+l
	 SSnJec2OKLc5u1YMM+hA5ULZXb72vbr6jdVQuhkxnTwzupRQDDK83Ynbtg1u5lxbx6
	 e+rw3MU5GLfqqUtVQH7zTctwLj1feufo6uGNLGWNLUsE7r91UjfxwYx5WKbwIHTJnp
	 ZzQGzv2TOML3sfz06YqwNF1A7aJS4mY1bz9UfnKn1AGLNZT3+bozC6rwxAHLhDcaTm
	 1YrRE5nmSz5aDZT/9g9lTXmbU5cCpTyNQHBf0qC+E8Oj9P+4U/Lr027D8mWh58zkNb
	 UrGZUBIKJT61g==
Date: Fri, 11 Oct 2024 16:55:29 -0500
From: Rob Herring <robh@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Saravana Kannan <saravanak@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree fixes for v6.12, part 1
Message-ID: <20241011215529.GA2601838-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull a few fixes for 6.12.

Rob


The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.12-1

for you to fetch changes up to 6e0391e48cf9fb8b1b5e27c0cbbaf2e4639f2c33:

  of: Skip kunit tests when arm64+ACPI doesn't populate root node (2024-10-10 12:43:01 -0500)

----------------------------------------------------------------
Devicetree fixes for v6.12, part 1:

- Disable kunit tests for arm64+ACPI

- Fix refcount issue in kunit tests

- Drop constraints on non-conformant 'interrupt-map' in fsl,ls-extirq

- Drop type ref on 'msi-parent in fsl,qoriq-mc binding

- Move elgin,jg10309-01 to its own binding from trivial-devices

----------------------------------------------------------------
Fabio Estevam (1):
      dt-bindings: display: elgin,jg10309-01: Add own binding

Frank Li (2):
      dt-bindings: misc: fsl,qoriq-mc: remove ref for msi-parent
      dt-bindings: interrupt-controller: fsl,ls-extirq: workaround wrong interrupt-map number

Jinjie Ruan (1):
      of: Fix unbalanced of node refcount and memory leaks

Stephen Boyd (1):
      of: Skip kunit tests when arm64+ACPI doesn't populate root node

 .../bindings/display/elgin,jg10309-01.yaml         | 54 ++++++++++++++++++++++
 .../interrupt-controller/fsl,ls-extirq.yaml        | 26 +++++++++--
 .../devicetree/bindings/misc/fsl,qoriq-mc.yaml     |  2 +-
 .../devicetree/bindings/trivial-devices.yaml       |  2 -
 drivers/of/of_kunit_helpers.c                      | 15 ++++++
 drivers/of/of_private.h                            |  3 ++
 drivers/of/of_test.c                               |  3 ++
 drivers/of/overlay_test.c                          |  5 +-
 8 files changed, 103 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/elgin,jg10309-01.yaml

