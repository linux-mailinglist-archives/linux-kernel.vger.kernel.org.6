Return-Path: <linux-kernel+bounces-446485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D1C9F24E5
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 18:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F0F816218A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 17:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1891B2180;
	Sun, 15 Dec 2024 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="xAdJlwWG"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6271B219D
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734282616; cv=none; b=bP/C1LOU8Mis8+531KEvPR7vLKzHthN72IST8LZXZLZDVY+W3PN988rMqfGtBAnQwbKp4XOPBivKV4N85/JR197Y1TU7NJgC8bmF4nqJPdf9g2sXR61ycPEVQd998Qvr29UUZgvhiS3o9JS8pBWfJGP3S7zG5BSDbA7nv6kMsgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734282616; c=relaxed/simple;
	bh=0+g+RK4mm+gXK4FknZi+afJu+Pu6+v4iIIJSvUsfP74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h+JHsrSLQSvQ5IZlak5gTiJ2/Ck0wjpRgueyUjdV05cLpEaC8OLdvKw/Hg7tzkZnDd9+pHhVoAOvF62smPZkj6+tLeHdXn8IzRvdbSPPK/gJTI8uSs5qtiEUv2arz367DiXyOay0dsq1XcBfL3Vo8X5+DodlbDoak3noA7ByyAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=xAdJlwWG; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
DKIM-Signature: a=rsa-sha256; b=xAdJlwWGZcpzPGneW+nYOyAW9OLBj2j7IBzkaWPLPnPmri/9zWDy4SkkgdURob0ippmICXsv4ZOMP+sRj9+9BcEPOI4Zu01Bbrga82UJ8Bca9c9pOdESxv3pMZ/Q07j5VAYSRD8NTLC5ocWaVHiLcDyzxRSpsGZyvRjcKo0ewgTYb1YPOoAV+lEOeFYBB8QFLnbdaICJrV8vC5Q+et6jWahpxVwZLB6IuqBoZt6YN3hNxVd2kHY/8H2EvKUrUZbqtl6qlsXMhlhSGIUdquDKXn8Lf/mTgh1u/UVT/+CsTvlu7LyLiDHn7gM6JAOWSg3AOJkpABm4F506yYeSYFSgSw==; s=purelymail3; d=purelymail.com; v=1; bh=0+g+RK4mm+gXK4FknZi+afJu+Pu6+v4iIIJSvUsfP74=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68247:10037:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1363280443;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 15 Dec 2024 17:09:54 +0000 (UTC)
From: Igor Belwon <igor.belwon@mentallysanemainliners.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] arm64: dts: exynos990: Add cmu nodes
Date: Sun, 15 Dec 2024 18:08:02 +0100
Message-ID: <20241215170803.1756850-1-igor.belwon@mentallysanemainliners.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Hi all,

This patchset adds device tree nodes for Exynos990 CMUs (TOP and HSI0).

This allows the first two implemented CMU blocks to be used.

Changes since v1:
- Fix clock-names formatting (Thanks, Krzysztof!)
- Remove stray blank line (Thanks, Krzysztof!)
- Make clock-names conform with the binding style

Best regards,
Igor

Igor Belwon (1):
  arm64: dts: exynos990: Add clock management unit nodes

 arch/arm64/boot/dts/exynos/exynos990.dtsi | 28 +++++++++++++++++++++++
 1 file changed, 28 insertions(+)

--=20
2.45.2


