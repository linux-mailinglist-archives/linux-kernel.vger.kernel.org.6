Return-Path: <linux-kernel+bounces-332129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B1B97B5CB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 00:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7357C1C20D0B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 22:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623C519308A;
	Tue, 17 Sep 2024 22:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEjjgmbt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2369192594;
	Tue, 17 Sep 2024 22:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726612162; cv=none; b=OlZR4ATNI/UKhyzUSUbEQU6FM7pLBbPN+QC0q6EUvkutdSeTs7S0CM/LwndGAegNL4llZrsmlAVpr0atHqqPjOVFZEwcqTkt3ITvWXLK3HHQlX0OqkKwS5DHFKKRYQ4QYU9/myMBvQP8JN7sC9XWW7Dz3ujvN77ce14UqFZLCfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726612162; c=relaxed/simple;
	bh=0nG1L7z//mYn4ixANqc8kqQI/L9SXIPVfW4TJSWpU5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYPghY4k17+IXZ77hwKlbTl5XWkd462/V9tBX3ZEenGlDy5Qs+VQ3ecM9IicXBAkM5Y6x1t4n7ek9cnZRIXqGSoqJMQlPQIEpHLeeVBMCi2Wm4c2hpC9OxNzPEYOdvzUeIWLFtt2PZT4si7/EOt00x+NJl+hqAcDXfMqbEcJ4Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEjjgmbt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA22C4CEC5;
	Tue, 17 Sep 2024 22:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726612162;
	bh=0nG1L7z//mYn4ixANqc8kqQI/L9SXIPVfW4TJSWpU5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YEjjgmbtd6IlzI/vTSTOVNjCcM7F/G41mlN1+vBZYOREe7l3YVHUxp8ZB3tBdWSB4
	 y4LhjWMP4sJLUnfJI+a1ueJrkU3R7TEKJFVGjyZdUPx4ZkIX0yotJIxDrJo69J4mXG
	 BSZmm4gp/0XWHcaEUxSuz41hMjEt07+HU487D5XNb49HTtQ7m8heYbHIPyitZR727k
	 D6g43io/PgpHISKRn3VZUrq5Nr+uMX7Bqu7BedDc+7cA5eGQM8scf+zxxBBHSFBV+h
	 zFzrIKfW7mxKR/R0Opb0Jtl3CnItxGZbrombAq1YmePDgfMJewDiA/d69b9j7yDQa7
	 1M0MDtPC6BBDA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/14] rust: hrtimer: add maintainer entry
Date: Wed, 18 Sep 2024 00:27:38 +0200
Message-ID: <20240917222739.1298275-15-a.hindborg@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917222739.1298275-1-a.hindborg@kernel.org>
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=882; i=a.hindborg@kernel.org; h=from:subject; bh=0nG1L7z//mYn4ixANqc8kqQI/L9SXIPVfW4TJSWpU5k=; b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb mtvWTNjQnl5WmlBR2JxQWdMdk5SVG9ZOG9UVVlkM1FUVEhXNzV0CkYrMjhXd3ZGOW5MMGRFR0ZE TU9qRllrQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKbTZnSUN BQW9KRU9HNEdqNTVLR04zUXRnUC8yU0FOaUVDUGl0L2haVEN3TmcrU2ErN3FZbHVlNXBGUUZjRw pwNis0cDdWSVhGNCtjWmg3TjNseWlYRFVmR24rUTFwbkFTVmQ2elVYTFdLQUw4RFpWY3FHaGRhZ 0VpaUFHT1NKCmVIQmlYK0ZPTFNQejZHLzA3THJCNTMvcDJHcy83UVpuMWlsdlZ3OTF0bDlRcWNt M293OGFDWHFZUlBnSTM0WkMKblJ1engwN2xsTUJWODFOWEljSy92ektBMENES3BNcXo2RGU4VFQ zOTVuUGFUU1VqTStyMDlvQXh1YUJwMVllKwpaZUJMaTN5S2dDSXViMDNiOXR3V3ZDK2RjL1c0Yl VaTExVa3N2bi9nTlVQclk2T2ZoZVJnMWMwOW15R0Y2UTlqCnl4MHBybWlPTXQyR2E1bWtMZlR1K 2Nua3RMV3JGSWRZNTZid1NmS2ZBUFdmUG1pV3RLbzAxQ2F1WWJlWUFXL1UKWEVHT2ZDOFFMTnV3 QjRQUHNMNmY1bDlta0pNbGYyK0lFZHlFQ1lpb2VUL0paMmlFWVhmRVZ4L2c1OTVMaWVqLwpVbjZ Lc2NqcHhjOEd5SjVwVF
 kxemt2cGRZbHFhZ29hcHBrV24vcnl3RnhmUHJzUUg2YTdOZEFWU295TD Q3cldhCm1JckhsajQ4TDh1SkVVbE8yd25wUjZmczNPS3ozdXpYck5qODdPT09NZ01kSVB5Y210d HdCaGRyZWk4ZFlXZkkKZXBCS2E3RmxsVk9HcWhQQzQyUDdMU1YzT0daZ2ZPdTJFOHF2S0h6cjgy SVBDUDNPZ09XMmxuK3BtUWppN3hETAo5VDI5VmR4UUI3QlhNeVVCY2k2dWZ4b3ZJcDdjZW5XZXF tMW1Cd0p2cDdGMmU5NC80dzRwSEZXM1hsb2VXcU51CkpLcHhLdGxiaTZ3czlnPT0KPW5MUXEKLS 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp; fpr=3108C10F46872E248D1FB221376EB100563EF7A7
Content-Transfer-Encoding: 8bit

Add Andreas Hindborg as maintainer for Rust `hrtimer` abstractions. Also
add Boqun Feng as reviewer.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc40a9d9b8cd..018847269dd3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10035,6 +10035,16 @@ F:	kernel/time/timer_list.c
 F:	kernel/time/timer_migration.*
 F:	tools/testing/selftests/timers/
 
+HIGH-RESOLUTION TIMERS [RUST]
+M:	Andreas Hindborg <a.hindborg@kernel.org>
+R:	Boqun Feng <boqun.feng@gmail.com>
+L:	rust-for-linux@vger.kernel.org
+S:	Supported
+W:	https://rust-for-linux.com
+B:	https://github.com/Rust-for-Linux/linux/issues
+F:	rust/kernel/hrtimer.rs
+F:	rust/kernel/hrtimer/
+
 HIGH-SPEED SCC DRIVER FOR AX.25
 L:	linux-hams@vger.kernel.org
 S:	Orphan
-- 
2.46.0



