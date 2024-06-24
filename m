Return-Path: <linux-kernel+bounces-227798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FB79156AB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4422840C6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC70F19EED7;
	Mon, 24 Jun 2024 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXtXonHv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC1E1BC20;
	Mon, 24 Jun 2024 18:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719255200; cv=none; b=bZYnrvq/OSifWc+Q7V0y5ib43XvjeIoZDkUXQgTOm3hVu8UOcll1JW7lQb5DX4eTuFF6+BG84CFxBZFAqNSirmay8CKJRAsVpdQxb9Xwi17i6EUkePnN+Kx9ylpUHpfiDpO/4bFf3KHkGBkgCEtBNTh/8pRsNDENJ6weQTbL1fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719255200; c=relaxed/simple;
	bh=5SQ6k8ql2FtQ24ggunQpn42cMs/9ehVKj7ffUjrSWaY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MLg9oNn3B52jrj0ynaJOqin26VxBpxwm88RoxzDWwRcwCx0Ws6bNR6fTS+AQDSzDFJsQLaQejHPuG8/k3++qIQpkRxc+iYT7VR3GxKkSlwgBqCzgLUElSUXQcbcbQsEvwr2Xv3zT9DBOtuQtn701X0v/SULYElD74Kb6FUJGeYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXtXonHv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84DEC2BBFC;
	Mon, 24 Jun 2024 18:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719255199;
	bh=5SQ6k8ql2FtQ24ggunQpn42cMs/9ehVKj7ffUjrSWaY=;
	h=From:To:Cc:Subject:Date:From;
	b=VXtXonHvyo+lWD0+pd+wr848CsLJDdbee4dVtqEC+taFZleV+/ScGSS1Uh5KTQv5a
	 QnFj79HuE41StMAO09LmxsiUmLstImWmWCDWn9q/8trkmxUYT8DvzromPaS2Qg6S+c
	 yV+9dimLGjxNQQ9lyL5Leh41aBeHHK3yr2nSTCCobOdAmIQfQluJ2yGek/SeYlcNbS
	 NwEYmE70UeDPIsdiuGmk/c3RnO+nRiAyMNO1/lHiMhtxOY+SkmgIYqN7gcT3Z1UQaq
	 +sF+wjYNdfcq3fyuNJpJ+OypNUfBlIgqoSAUVIEwvBslVQ4xxkIFgnhj+a4ejS3oRM
	 Svk9o0CE5wYNw==
From: SeongJae Park <sj@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: SeongJae Park <sj@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alex Shi <alexs@kernel.org>,
	Avadhut Naik <avadhut.naik@amd.com>,
	Bill Wendling <morbo@google.com>,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>,
	Federico Vaga <federico.vaga@vaga.pv.it>,
	Hu Haowen <2023002089@link.tyut.edu.cn>,
	Justin Stitt <justinstitt@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev,
	workflows@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] minor document fixups
Date: Mon, 24 Jun 2024 11:53:05 -0700
Message-Id: <20240624185312.94537-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series is for minor document fixups.  First five patches
clean up and remove 'Other material' section of process/index in favor
of 'staging/' and better place for docs on the section.  A patch for
adding DAMON maintainer-profile reference on maintainers' handbook
follows.  And then the last patch adds 'hkml' as one of available email
tools on email-clients document.

SeongJae Park (7):
  Docs/process/index: Remove unaligned-memory-access from 'Other
    material'
  Docs/process/index: Remove riscv/patch-acceptance from 'Other
    material' section
  Docs: Move magic-number from process to staging
  Docs: Move clang-format from process/ to dev-tools/
  Docs/process/index: Remove unsorted docs section
  Docs/maintainer/maintainer-entry-profile: add DAMON maintainer profile
  Docs/process/email-clients: Document HacKerMaiL

 .clang-format                                         |  2 +-
 Documentation/{process => dev-tools}/clang-format.rst |  0
 Documentation/dev-tools/index.rst                     |  1 +
 Documentation/maintainer/maintainer-entry-profile.rst |  1 +
 Documentation/process/4.Coding.rst                    |  2 +-
 Documentation/process/coding-style.rst                |  2 +-
 Documentation/process/email-clients.rst               |  9 +++++++++
 Documentation/process/index.rst                       | 11 -----------
 Documentation/staging/index.rst                       |  1 +
 Documentation/{process => staging}/magic-number.rst   |  0
 .../translations/it_IT/process/clang-format.rst       |  2 +-
 .../translations/it_IT/process/magic-number.rst       |  2 +-
 .../translations/sp_SP/process/coding-style.rst       |  2 +-
 .../translations/sp_SP/process/magic-number.rst       |  2 +-
 Documentation/translations/zh_CN/process/4.Coding.rst |  2 +-
 .../translations/zh_CN/process/coding-style.rst       |  2 +-
 .../translations/zh_CN/process/magic-number.rst       |  2 +-
 Documentation/translations/zh_TW/process/4.Coding.rst |  2 +-
 .../translations/zh_TW/process/coding-style.rst       |  2 +-
 .../translations/zh_TW/process/magic-number.rst       |  2 +-
 20 files changed, 25 insertions(+), 24 deletions(-)
 rename Documentation/{process => dev-tools}/clang-format.rst (100%)
 rename Documentation/{process => staging}/magic-number.rst (100%)


base-commit: 88407e61007a3d3ebb62fc65479cc58d891ef74e
-- 
2.39.2


